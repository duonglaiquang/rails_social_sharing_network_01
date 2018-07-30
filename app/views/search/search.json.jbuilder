json.users do
  json.array!(@users) do |user|
    json.name user.email
    json.url user_path(user.id)
  end
end

json.posts do
  json.array!(@posts) do |post|
    json.name post.title
    json.url root_path
  end
end
