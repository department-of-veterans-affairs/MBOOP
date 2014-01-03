json.array!(@folders) do |folder|
  json.extract! folder, :id, :category, :unique_id, :user_id
  json.url folder_url(folder, format: :json)
end
