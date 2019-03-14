Object = require 'vendor/classic'
Entity = Object:extend()

local BULLET_SPEED = 32

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

  self.animation = {
    gatherer = newAnimation(
      love.graphics.newImage("assets/gatherer.png"),
      28, 
      32, 
      1
    ),
    blacksmith = newAnimation(
      love.graphics.newImage("assets/blacksmith.png"),
      30, 
      32, 
      1
    ),
    merchant = newAnimation(
      love.graphics.newImage("assets/merchant.png"),
      33, 
      32, 
      1
    )
  }
end

function Entity:showEncounter(character, offset)
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  local sx = width - rightOffset - offset
  local sy = lineLength

  local tx = width - rightOffset - offset
  local ty = -48

  local angle = math.atan2(( ty - sy ), (tx - sx))

  local projectileProperties = {
    character = character,
    x = sx,
    y = sy,
    angle = angle
  }

  table.insert(self.mounted, projectileProperties)
end

function Entity:update(dt)
  for i,v in pairs(self.animation) do
    v.current = v.current + dt

    if v.current >= v.duration then
      v.current = v.current - v.duration
    end
  end

  for i,v in pairs(self.mounted) do
      local dx = BULLET_SPEED * math.cos(v.angle)
      local dy = BULLET_SPEED * math.sin(v.angle)
      v.x = v.x + (dx * dt)
      v.y = v.y + (dy * dt)
      
      if v.x > love.graphics.getWidth() or
         v.y > love.graphics.getHeight() or
         v.x < -48 or
         v.y < -48 then
        table.remove(self.mounted, i)
      end
  end
end

function Entity:draw()
  for i,v in pairs(self.mounted) do
    love.graphics.setColor(1, 1, 1)

    local spriteNum = math.floor(
      self.animation[v.character].current 
      / self.animation[v.character].duration
      * #self.animation[v.character].quads
    ) + 1

    love.graphics.draw(
      self.animation[v.character].spriteSheet,
      self.animation[v.character].quads[spriteNum],
      v.x,
      v.y,
      0,
      1
    )
  end
end

return Entity