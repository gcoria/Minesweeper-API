json.array! @games do |game|
  json.(game, :id, :user_id, :rows, :columns, :mines, :state)
  json.duration game.duration
end