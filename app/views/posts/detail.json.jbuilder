json.array!(@posts) do |post|
  json.(post, :id, :text, :likes, :parent_id, :created_at)
end

