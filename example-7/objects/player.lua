math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(p)
  self.gold = p.gold
  self.day = 1
  self.animation = {
    duration = 1,
    current = 0
  }
end

function Entity:sell(inventory)
  local result = inventory:dump()

  self.gold = self.gold + result

  if result == 0 then
    return false
  end

  return true
end

function Entity:update(dt)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
    self.day = self.day + 1
  end
end

function Entity:draw()
  width = love.graphics.getWidth()
  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("" .. self.gold .. "g", 16, 16, width, "left")

  love.graphics.setColor(255, 255, 255)
  love.graphics.printf("Day " .. self.day .. "", -16, 16, width, "right")
end

return Entity
