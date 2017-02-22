# MBOOP

This app keeps track of physical items as they move through a group of people. While initially designed for folders, you can easily repurpose it for other physical items too.

A simple USB scanner, with autofocus set to true, makes this Web app work without installing any firmware/software.

### Prerequisites

- Get access to https://dashboard.heroku.com/apps/folderfinder

1. Login in to heroku.
```
$ heroku login
Enter your Heroku credentials.
Email: maintainer@va.gov
Password:
Could not find an existing public key.
Would you like to generate one? [Yn]
Generating new SSH public key.
Uploading ssh public key /Users/adam/.ssh/id_rsa.pub
```
2. Create copy of database. This is in case something gets messed up.
```
$ heroku pg:backups:capture [DATABASE] --app folderfinder
```
5. Login to rails console in heroku
```
$ heroku run rails console --app folderfinder 
```
6. Find and validate user with their email address.
```
irb(main):001:0> User.find_by_email('new.person@va.gov')
=> #<User id: 00, email: "new.person@va.gov", encrypted_password: "xxxx...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: "2017-02-15 15:46:07", sign_in_count: 39, current_sign_in_at: "2017-02-22 16:59:57", last_sign_in_at: "2017-02-22 15:09:20", current_sign_in_ip: "152.130.15.14", last_sign_in_ip: "152.130.15.14", created_at: "2016-10-17 14:00:15", updated_at: "2017-02-22 16:59:57", display_name: "New Person", admin: false, active: false>
```
7. Make note of the users ID and make updates as needed.

To user give a user admin permissions:
```
irb(main):003:0> @b = User.find(00)
=> #<User id: 00, email: "new.person@va.gov", encrypted_password: "xxxx...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: "2017-02-15 15:46:07", sign_in_count: 39, current_sign_in_at: "2017-02-22 16:59:57", last_sign_in_at: "2017-02-22 15:09:20", current_sign_in_ip: "152.130.15.14", last_sign_in_ip: "152.130.15.14", created_at: "2016-10-17 14:00:15", updated_at: "2017-02-22 16:59:57", display_name: "New Person", admin: false, active: false>
irb(main):004:0> @b.admin = true
=> true
irb(main):005:0> @b.save
=> true
```

To add a user:
```
irb(main):003:0> @b = User.find(00)
=> #<User id: 00, email: "new.person@va.gov", encrypted_password: "xxxx...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: "2017-02-15 15:46:07", sign_in_count: 39, current_sign_in_at: "2017-02-22 16:59:57", last_sign_in_at: "2017-02-22 15:09:20", current_sign_in_ip: "152.130.15.14", last_sign_in_ip: "152.130.15.14", created_at: "2016-10-17 14:00:15", updated_at: "2017-02-22 16:59:57", display_name: "New Person", admin: false, active: false>
irb(main):004:0> @b.active = true
=> true
irb(main):005:0> @b.save
=> true
```

To remove a user:
```
irb(main):003:0> @b = User.find(00)
=> #<User id: 00, email: "new.person@va.gov", encrypted_password: "xxxx...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: "2017-02-15 15:46:07", sign_in_count: 39, current_sign_in_at: "2017-02-22 16:59:57", last_sign_in_at: "2017-02-22 15:09:20", current_sign_in_ip: "152.130.15.14", last_sign_in_ip: "152.130.15.14", created_at: "2016-10-17 14:00:15", updated_at: "2017-02-22 16:59:57", display_name: "New Person", admin: false, active: false>
irb(main):004:0> @b.active = false
=> true
irb(main):005:0> @b.save
=> true
```
