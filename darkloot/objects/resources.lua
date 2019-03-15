Object = require 'vendor/classic'
Entity = Object:extend()

local function insertResource(t, resource, amount)
  found = false

  for i, v in ipairs (t) do
    if (v.resource == resource) then
      t[i].amount = t[i].amount + amount
      found = true
    end
  end

  if found == false then
    table.insert(t, {
      resource = resource,
      amount = amount
    })
  end
end

function Entity:new(p)
  self.items = p.items
end

function Entity:add(resource, amount)
  insertResource(self.items, resource, amount)
end

function Entity:remove(resource, amount)
  for i, v in ipairs (self.items) do
    if (v.resource == resource) then
      if (v.amount >= amount) then
        self.items[i].amount = self.items[i].amount - amount
        return amount
      end
    end
  end

  return 0
end

function Entity:update(dt)
  -- todo
end

function Entity:draw()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()

  for i, item in reversedipairs(self.items) do
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "x" .. item.amount ..
      " " .. item.resource .. "",
       -320 - 16,
        height - 104 - (i * 24),
        width,
        "right"
    )
  end
end

return Entity
