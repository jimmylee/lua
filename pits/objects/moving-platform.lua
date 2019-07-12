math.randomseed(os.time())

Object = require 'libs/classic'
Entity = Object:extend()

function Entity:new(state)
  self.width = state.width
  self.height = state.height
  self.x = state.x
  self.y = state.y
  self.direction = state.direction
  self.yv = 0
  self.xv = 0
  self.dropping = 0
end

function Entity:update(dt)
  if self.direction == 1 then
    self.yv = -2000 * dt
    if self.dropping > 0 then
      self.yv = 2000 * dt
      self.y = self.y + self.yv * dt
      self.dropping = self.dropping - 1
    else
      self.y = self.y + self.yv * dt
    end
  end

  if self.direction == 0 then
    self.yv = 2000 * dt
    self.y = self.y + self.yv * dt
  end

  if self.direction == 2 then
    self.xv = 2000 * dt
    self.x = self.x + self.xv * dt
  end

  -- moving platforms right.
  if self.direction == 3 then
    self.xv = -2000 * dt
    self.x = self.x + self.xv * dt
  end

  -- the blocks can't go too far up.
  if self.y < 0 then
    self.y = 0
  end

  -- the blocks can't go too far left.
  if self.x < 0 then
    self.x = 0
  end

  -- dont let the blocks go too far right
  if self.x > love.graphics.getWidth() - 32 then
    self.x = love.graphics.getWidth() - 32
  end

  -- the blocks can't go too far down.
  if self.y > love.graphics.getHeight() - 32 then
    self.y = love.graphics.getHeight() - 32
  end
end

function Entity:draw()
  love.graphics.setColor(1, 1, 1)

  local image
  if self.direction == 1 then
    image = assets[2]
  elseif self.direction == 2 then
    image = assets[4]
  elseif self.direction == 3 then
    image = assets[3]
  else
    image = assets[5]
  end

love.graphics.draw(image, self.x, self.y)
  -- love.graphics.rectangle(
  --   'fill',
  --  self.x,
  --  self.y,
  --  self.width,
  --  self.height
  -- )
end

return Entity


