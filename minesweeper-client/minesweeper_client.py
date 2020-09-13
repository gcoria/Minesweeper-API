import requests

class MinesweeperClient:
  BASE_URL = 'https://glacial-oasis-14537.herokuapp.com'

  def createUser(self, username, password):
    return requests.post(
      url=self.BASE_URL+'/users',
      json={
        "username": username,
        "password": password
            }
    ).json()

  def getUser(self, userId):
    return requests.get(url=self.BASE_URL+'/users/'+str(userId)).json()

  def listUsers(self):
    return requests.get(url=self.BASE_URL+'/users').json()

    
  def createGame(self, userId, rows, columns, mines):
    return requests.post(
      url=self.BASE_URL+'/users/'+str(userId)+'/games',
      json={
        "rows": rows,
        "columns": columns,
        "mines": mines
      }
    ).json()

  def listUserGames(self, userId):
    return requests.get(url=self.BASE_URL+'/users/'+str(userId)+'/games').json()
  
  def getGame(self, userId, gameId):
    return requests.get(url=self.BASE_URL+'/users/'+str(userId)+'/games/'+str(gameId)).json()

  def markCell(self, userId, gameId, x_axis, y_axis):
    return requests.put(url=self.BASE_URL+'/users/'+str(userId)+'/games/'+str(gameId)+'/mark/'+str(x_axis)+'/'str(y_axis)).json()

  def revealCell(self, userId, gameId, x_axis, y_axis):
    return requests.put(url=self.BASE_URL+'/users/'+str(userId)+'/games/'+str(gameId)+'/reveal/'+str(x_axis)+'/'str(y_axis)).json()  
 