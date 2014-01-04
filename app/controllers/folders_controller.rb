class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy, :complete, :move]
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource except: [:create]

  def mine
    @folders = current_user.folders.where(:completed => false).order(sort_column + ' ' + sort_direction)
  end
  
  def complete
    @folder.update_attributes(:completed => true)
    redirect_to folders_path
  end
  
  def checkedin
    @folder = Folder.where(:unique_id => params[:unique_id]).first
    #redirect_to @folder
    @folder.update_attributes(:user_id => current_user.id)
    redirect_to mine_path
  end
  
  def move
    @folder = Folder.find(params[:id])
    @folder.update_attributes(:user_id => params[:user_id])
    redirect_to folders_path
  end

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.where(:completed => false).order(sort_column + ' ' + sort_direction)
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @barcode = Barby::Code128B.new(@folder.unique_id)
    @histories = @folder.histories
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    #@folder = Folder.new(folder_params)
    @folder = current_user.folders.build(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render action: 'show', status: :created, location: @folder }
      else
        format.html { render action: 'new' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    
    @new_owner = User.find(params[:folder][:user_id]).display_name
    @story = "Moved from " + @folder.user.display_name + " to " + @new_owner + " by " + current_user.display_name
    @history = @folder.histories.build(:action => @story)
    
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:category, :unique_id, :user_id)
    end
    
    def sort_column
      Folder.column_names.include?(params[:sort]) ? params[:sort] : "unique_id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
end
