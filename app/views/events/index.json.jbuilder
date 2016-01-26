json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :start_time, :end_time, :rule, :user_id
  json.url event_url(event, format: :json)
end
