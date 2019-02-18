User.create!(      provider: "twitter",
                   uid:1,
                   user_name: "Example")

7.times do |n|
  name  = Faker::Name.name
  User.create!(   provider: "twitter",
                  uid:n+1,
                  user_name: name)
end