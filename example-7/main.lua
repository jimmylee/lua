local Activity = require 'objects/activity' 
local Resources = require 'objects/resources'
local Inventory = require 'objects/inventory';

function love.load()
  font = love.graphics.newFont("Masuria.ttf", 20)
  love.graphics.setFont(font)

  activity = Activity({ 
    items = {} 
  })

  resources = Resources({ 
    items = {} 
  })

  inventory = Inventory({
    items = {}
  })
end

function love.update(dt)
  activity:update(dt, "John's search has returned something.", resources, 1)
  resources:update(dt, 'copper')
  inventory:update(dt, resources)
end

function love.draw()
  activity:draw()
  resources:draw()
  inventory:draw()
end