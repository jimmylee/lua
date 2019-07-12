math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
  self.width = state.width
  self.height = state.height
  self.x = state.x
  self.y = state.y
end

function Entity:update(dt)
--
end

function Entity:draw()
  love.graphics.setColor(1, 1, 1)
  image = assets[0]
  love.graphics.draw(image, self.x, self.y)
end

return Entity