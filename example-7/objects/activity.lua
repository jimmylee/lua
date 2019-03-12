math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local function removeBeginningIndex(tab, val)
  for i, v in ipairs (tab) do 
    if (v.index == val) then
      tab[i] = nil
    end
  end
end

local function gainResource(resources, amount)
  randomValue = math.random(1, 10)
  choice = 'bone'

  if (randomValue > 7) then
    choice = 'copper'
  end

  resources:add(choice, amount)
end

function Entity:new(p)
  self.items = p.items
  self.animation = { current = 0, duration = 0.4 }
  self.count = 0;
  self.start = 1;
  self.size = 0;
end

function Entity:update(dt, text, resources, amount)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration

    self.count = self.count + 1
    self.size = self.size + 1
    table.insert(self.items, {
      text = text, 
      index = self.count
    })

    gainResource(resources, amount)
  end

  height = love.graphics.getHeight()

  if self.size * 28 > height then
    removeBeginningIndex(self.items, self.start)
    self.size = self.size - 1
    self.start = self.start + 1
  end
end

function Entity:draw()
  iterations = 0;
  for i, item in pairs(self.items) do
    if item.index >= self.start then
      iterations = iterations + 1
      love.graphics.print(
        "" .. item.text .. 
        " ",
        16,
        -8 + (iterations * 24)
      )
    end
  end
end

return Entity