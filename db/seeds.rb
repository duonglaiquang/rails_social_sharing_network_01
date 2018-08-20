avatar = Faker::Avatar.image
User.create!(name: "Example User",
             email: "duonglaiquang@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             avatar: avatar,
             admin: true,
             activated: true)

99.times do |n|
  name = Faker::Name.name
  bio = Faker::Lorem.paragraph
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  avatar = Faker::Avatar.image
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               avatar: avatar,
               bio: bio,
               activated: true)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

20.times do
  name = Faker::Overwatch.hero
  Tag.create!(name: name)
end

25.times do
  title = Faker::Movie.quote
  content = Faker::Avatar.image
  user_id = Faker::Number.between(1, 50)
  point = Faker::Number.between(1, 800)
  upload_type = 2
  tag_id = Faker::Number.between(1, 20)

  Post.create!(title: title,
               user_id: user_id,
               upload_type: upload_type,
               content: content,
               point: point,
               tag_id: tag_id)
end

100.times do
  content = Faker::Lorem.paragraph
  user_id = Faker::Number.between(1, 50)
  post_id = Faker::Number.between(1, 20)
  point = Faker::Number.between(1, 50)
  Comment.create!(content: content,
                  user_id: user_id,
                  post_id: post_id,
                  point: point)
end

Post.all.each do |f|
  f.comments.each do |t|
    2.times do
      content = Faker::Lorem.paragraph
      user_id = Faker::Number.between(1, 50)
      point = Faker::Number.between(1, 50)
      Comment.create!(content: content,
                      user_id: user_id,
                      post_id: f.id,
                      parent_id: t.id,
                      reply_id: t.id,
                      point: point)
    end
  end
end
