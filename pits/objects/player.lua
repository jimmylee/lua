require "objects/dynamic-entity"

Player = DynamicEntity:extend();

function getImageScaleForNewDimensions( image, newWidth, newHeight )
  local currentWidth, currentHeight = image:getDimensions()
  return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

function Player:new(x, y, w, h, world, mvx, mvy, speed)
  Player.super.new(self, x, y, w, h, nil, world, mvx, mvy, "PLAYER", 2)
  self.width = w
  self.height = h
  self.origX = x;
  self.origY = 0;
  self.speed = speed
  self.omvx = mvx;
  self.tempDistance = ""
end

function Player:update(dt)  
  self.mvx = self.omvx

  return self
end

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  image = assets[6]
  local scaleX, scaleY = getImageScaleForNewDimensions( image, 16, 16 )
  love.graphics.draw(image, self.x, self.y, 0, scaleX, scaleY)
end

function Player:checkCols(cols)
  Player.super:checkCols(cols)
  self.grounded = false
  for i,v in ipairs (cols) do
    if cols[i].normal.y == -1 then
      self.yv = 0
      self.grounded = true
    elseif cols[i].normal.y == 1 then
      self.yv = -self.yv / 4
    end

    if cols[i].normal.x ~= 0 and cols[i].other.xv == nil then
      self.xv = 0
    end
  end
end

function Player:moveRight(dt)
  self.xv = self.xv + self.speed

  self.direction = 1
  if self.direction == -1 then
    self.xv = 0
  end
end

function Player:moveLeft(dt)
  self.xv = self.xv + self.speed

  self.direction = -1
  if self.direction == 1 then
    self.xv = 0
  end
end

function Player:jump(dt)
  if self.grounded == true then
    self.yv = self.yv - 300;
  end
end