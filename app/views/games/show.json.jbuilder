json.(@game, :id, :user_id, :rows, :columns, :mines, :state)
json.duration @game.duration
json.cells do
  json.array! @game.cells do |cell|
    json.x_axis cell.x_axis
    json.y_axis cell.y_axis
    json.state cell.state
    json.mines_around cell.mines_around
  end
end