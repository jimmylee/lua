math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local function reversedipairsiter(t, i)
  i = i - 1
  if i ~= 0 then
    return i, t[i]
  end
end

function reversedipairs(t)
  return reversedipairsiter, t, #t + 1
end

local function removeBeginningIndex(tab, val)
  for i, v in ipairs (tab) do
    if (v.index == val) then
      tab[i] = nil
    end
  end
end

function Entity:new(p)
  self.items = p.items
  self.count = 0;
  self.start = 1;
  self.size = 0;
end

function Entity:update(dt, text)
  self.count = self.count + 1
  self.size = self.size + 1
  table.insert(self.items, {
    text = text,
    index = self.count
  })

  height = love.graphics.getHeight()

  if self.size * 28 > height then
    removeBeginningIndex(self.items, self.start)
    self.size = self.size - 1
    self.start = self.start + 1
  end
end

function Entity:draw()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  iterations = 0;
  segments = (height - 64) / 28
  unit = 1 / segments
  for i, item in reversedipairs(self.items) do
    if item == nil then
      return false
    end

    if item.index >= self.start then
      iterations = iterations + 1
      hex = 1 - (unit * iterations)
      love.graphics.setColor(hex, hex, hex)
      love.graphics.printf(
        "" .. item.text ..
        " ",
        16,
        height - 64 - (iterations * 24),
        width
      )
    end
  end
end

return Entity
