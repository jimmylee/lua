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
  self.animation = { 
    current = 0,
    duration = 0.7
  }
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

function Entity:update(dt, resource)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration

    -- insertResource(self.items, resource, 1)
  end
end

function Entity:draw()
  for i, item in ipairs (self.items) do
    love.graphics.print(
      "" .. item.resource .. 
      " " .. item.amount .. "x",
       372,
        -8 + (i * 24)
    )
  end
end

return Entity