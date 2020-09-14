# Minesweeper-API 

[![Maintainability](https://api.codeclimate.com/v1/badges/7422b556dba761416724/maintainability)](https://codeclimate.com/github/gcoria/Minesweeper-API/maintainability) [![Build Status](https://travis-ci.com/gcoria/Minesweeper-API.svg?branch=master)](https://travis-ci.com/gcoria/Minesweeper-API)

minesweeper-API is a rest api for the popular game Minesweeper.

### Game Summary
- Create multiple users
- List users
- Get user by id 
- Create new games
- Get a game by id
- Get all the games for a given user id
- Reveal a cell
- Mark a cell with a flag

### Decisions
- Games have 4 states `[is_new, in_progress, won, lost]`
- Cells have 3 states `[covered, revealed, flagged]`
- The game starts(state change from `is_new` to `in_progress`) when you mark or reveal a cell
- Game duration shows the time in minutes when the game ends(state is `won` or `lost`)
- Flagged cell can be revealed with a direct reveal on that cell or return to covered with the mark action
- Api responses never gives the information if a cell is mined 

### General notes
- It's a rails rest api
- It uses a Postgresql to persist the users and their games
- Game it's uploaded to heroku
- The design was following the MVC pattern
- Api has a [client](client.md) library
- All classes are tested


### Game Site 
```
https://glacial-oasis-14537.herokuapp.com
```

### Getting started

#### Setup
```
rbenv install 2.6.3
gem install bundler
bundle install
bundle exec rake db:create db:migrate
bundle exec rake db:create db:migrate RAILS_ENV=test
bundle exec rspec spec/
```

#### Run in local environment
```
rails s
Ready and running at http://localhost:3000/
```


## Endpoints 

#### Create User
```http
POST /users
```

```json
{
	 "username": "gaston",
	 "password": "123456"
}
```
Response
```json
{
  "id": 1,
  "username": "gaston",
  "password_digest": "....",
}
```

#### Get User
```http
POST /users/:id
```
Response
```json
{
  "id": 1,
  "username": "gasta"
}
```

#### Create Game
```http
POST /users/:id/games
```
Body

```json
{
  "columns": 3,
	"rows": 3,
	"mines": 6
}
```

Response
```json
{
  "id": 30,
  "user_id": 1,
  "state": "is_new"
}
```

#### Get game
```http
GET /users/:user_id/games/:id
```
Response
```json
{
  "id": 30,
  "user_id": 1,
  "rows": 3,
  "columns": 3,
  "mines": 6,
  "state": "is_new",
  "duration": "still_playing",
  "cells": [
    {
      "x_axis": 2,
      "y_axis": 2,
      "state": "covered",
      "mines_around": 1
    },
    ...
   ] 
}
```
### Get user games

```http
GET /users/:user_id/games
```
Response
```json
[
  {
    "id": 1,
    "user_id": 1,
    "rows": 8,
    "columns": 8,
    "mines": 8,
    "state": "is_new",
    "duration": "still_playing"
  },
  ...
]
```

### Mark a cell with a flag
```http
PUT /users/:user_id/games/:game_id/mark/:x_axis/:y_xis
```
Response
```json
{
  "id": 30,
  "user_id": 1,
  "rows": 3,
  "columns": 3,
  "mines": 6,
  "state": "is_new",
  "duration": "still_playing",
  "cells": [
    {
      "x_axis": 2,
      "y_axis": 2,
      "state": "covered",
      "mines_around": 1
    },
    ...
   ] 
}
```

### Reveal a cell
```http
PUT /users/:user_id/games/:game_id/reveal/:x_axis/:y_xis
```
Response
```json
{
  "id": 30,
  "user_id": 1,
  "rows": 3,
  "columns": 3,
  "mines": 6,
  "state": "is_new",
  "duration": "still_playing",
  "cells": [
    {
      "x_axis": 2,
      "y_axis": 2,
      "state": "covered",
      "mines_around": 1
    },
    ...
   ] 
}
```


