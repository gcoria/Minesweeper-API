#### MinesweeperClient
```http
POST createUser(username, password)
GET  getUser(userId)
POST createGame(userId, rows, columns, mines)
GET  listUserGames(userId)
GET  getGame(userId, gameId)
PUT  markCell(userId, gameId, x_axis, y_axis)
PUT  revealCell(userId, gameId, x_axis, y_axis)
```
