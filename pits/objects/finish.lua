math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
  self.width = state.width
  self.height = state.height
  self.x = state.x
  self.y = state.y
  self.name = state.name
end

function Entity:update(dt)
--
end

function Entity:draw()
  love.graphics.setColor(1, 1, 1)
  image = assets[1]
  love.graphics.draw(image, self.x, self.y)
end

return Entity