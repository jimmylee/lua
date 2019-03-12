math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

inventoryId = 0

local function insertItem(t, item) 
  found = false

  for i, v in ipairs (t) do
    if (v.id == item.id) then
      t[i].amount = t[i].amount + 1
      found = true
    end
  end

  if found == false then
    table.insert(t, { 
      id = item.id,
      name = item.name,
      base = item.base,
      sides = item.sides,
      modifier = item.modifier,
      amount = 1 
    })
  end
end

function Entity:new(p)
  self.items = p.items
  self.animation = { 
    current = 0,
    duration = 30
  }
end

function Entity:update(dt, resources)
  self.animation.current = self.animation.current + dt

  if self.animation.current >= self.animation.duration then
    self.animation.current = self.animation.current - self.animation.duration

    result = resources:remove('copper', 20)

    if result >= 20 then
      insertItem(self.items, {
        id = inventoryId,
        name = 'Rusty Copper Dagger',
        base = 1,
        sides = math.random(5,7),
        modifier = math.random(1,2)
      })

      inventoryId = inventoryId + 1
    end
  end
end

function Entity:draw()
  for i, item in pairs(self.items) do
    love.graphics.print(
      "" .. item.name .. 
      " " .. item.base .. 
      "d" .. item.sides .. 
      "+" .. item.modifier .. 
      " " .. item.amount .. "x",
       672,
        -8 + (i * 24)
    )
  end
end

return Entity