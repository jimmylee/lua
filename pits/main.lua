bump = require "libs/bump"
Object = require "libs/classic"
Levels = require "objects/levels"

require "objects/player"
require "game"

local cols
local GRAVITY
local map
local world
local entities = {}
local game

assets = {}

function love.load()
  trackOne = love.audio.newSource("microlith.mp3", "stream")
  trackOne:setLooping(true)
  love.audio.play(trackOne)

  user = castle.user.getMe()

  love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight()) 
  assets[0] = love.graphics.newImage("textures/tile.default.png")
  assets[1] = love.graphics.newImage("textures/tile.exit.png")
  assets[2] = love.graphics.newImage("textures/tile.blue.png")
  assets[3] = love.graphics.newImage("textures/tile.green.png")
  assets[4] = love.graphics.newImage("textures/tile.yellow.png")
  assets[5] = love.graphics.newImage("textures/tile.pink.png")
  assets[6] = love.graphics.newImage(user.photoUrl)
  assets[7] = love.graphics.newImage("textures/tile.spikes.png")
  game = Game(Levels[0])
end

function love.update(dt)
  game:update(dt);
end

function love.draw()
  game:draw(dt);
end

function love.mousepressed(x, y, button)
	-- game:loadLevel(DEFAULT_WORLD);
end

function love.resize(w, h)
	--
end
