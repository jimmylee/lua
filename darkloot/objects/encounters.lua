Object = require 'vendor/classic'
Entity = Object:extend()

local BULLET_SPEED = 100

-- shares with world.lua
local lineUnit = 48
local lineAnimationUnit = 1 / lineUnit
local extension = lineUnit * 8
local lineLength = lineUnit + extension
local largestY = 0
local rightOffset = 336
local rightIncrement = 240
local topOffset = 16

local function newAnimation(image, width, height, duration)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};

  local y = 0
  local x = 0

  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      table.insert(
        animation.quads, 
        love.graphics.newQuad(x, y, width, height, 
        image:getDimensions()))
    end
  end

  animation.duration = duration or 1
  animation.current = 0

  return animation
end

function Entity:new()
  self.mounted = {}
  self.animation = newAnimation(
    love.graphics.newImage("assets/gatherer.png"),
    28, 
    32, 
    1
  )
end

function Entity:showEncounter(offset)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  local sx = width - rightOffset
  local sy = lineLength

  local tx = width - rightOffset
  local ty = -48

  local angle = math.atan2(( ty - sy ), (tx - sx))

  local projectileProperties = {
    x = sx,
    y = sy,
    angle = angle
  }

  table.insert(self.mounted, projectileProperties)
end

function Entity:update(dt)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration
  end

  for i,v in pairs(self.mounted) do
      local dx = BULLET_SPEED * math.cos(v.angle)
      local dy = BULLET_SPEED * math.sin(v.angle)
      v.x = v.x + (dx * dt)
      v.y = v.y + (dy * dt)

      print(v.x)
      print(v.y)
      
      if v.x > love.graphics.getWidth() or
         v.y > love.graphics.getHeight() or
         v.x < 0 or
         v.y < 0 then
        table.remove(self.mounted, i)
      end
  end
end

function Entity:draw()
  for i,v in pairs(self.mounted) do
    local spriteNum = math.floor(self.animation.current / self.animation.duration * #self.animation.quads) + 1

    love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], v.x, v.y, 0, 1)
  end
end

return Entity