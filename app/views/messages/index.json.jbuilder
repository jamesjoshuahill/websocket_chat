json.array!(@messages) do |message|
  json.extract! message, :name, :content
  json.url message_url(message, format: :json)
end
