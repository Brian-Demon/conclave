namespace :admin do
  desc "Set a user to admin. Note: this only works once"
  task set: [:environment] do
    if User.where(auth_role: "admin").count > 0
      puts "User already exists with admin role! Have them help you!"
      exit 1
    end

    login = ARGV[0]
    unless login
      puts "You must specify a login to set as admin!"
      exit 1
    end

    user = User.find_by(login: login)
    unless user
      puts "User #{login} could not be found!"
      exit 1
    end

    if user.update(auth_role: "admin")
      puts "Successfully set #{login} to admin!"
      exit 0
    else
      puts "User could not be made admin! Reason: #{user.errors.full_messages}"
      exit 1
    end
  end
end