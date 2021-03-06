math.randomseed(os.time())

Object = require 'vendor/classic'
Entity = Object:extend()

local inventoryId = 0
local inventoryCount = 0

local materialChoices = {
  [1]="bone",
  [2]="copper",
  [3]="iron",
  [4]="wood"
}

local equipmentChoices = {
  [1]="dagger",
  [2]="sword"
}

local equipment = {
  sword = {
    iron = {
      modifier = 3,
      sides = { min = 14, max = 16 },
      base = 1,
      value = 600,
      rarity = 1
    },
    copper = {
      modifier = 2,
      sides = { min = 13, max = 14 },
      base = 1,
      value = 150,
      rarity = 1
    },
    bone = {
      modifier = 1,
      sides = { min = 12, max = 13 },
      base = 1,
      value = 75,
      rarity = 1
    },
    wood = {
      modifier = 0,
      sides = { min = 12, max = 12 },
      base = 1,
      value = 50,
      rarity = 1
    }
  },
  dagger = {
    iron = {
      modifier = 2,
      sides = { min = 8, max = 9 },
      base = 1,
      value = 50,
      rarity = 1
    },
    copper = {
      modifier = 1,
      sides = { min = 6, max = 7 },
      base = 1,
      value = 10,
      rarity = 1
    },
    bone = {
      modifier = 0,
      sides = { min = 4, max = 5 },
      base = 1,
      value = 5,
      rarity = 1
    },
    wood = {
      modifier = 0,
      sides = { min = 3, max = 3 },
      base = 1,
      value = 1,
      rarity = 1
    }
  }
}

local cost = {
  dagger = 5,
  sword = 20
}

local function insertItem(t, item)
  table.insert(t, {
    id = item.id,
    index = item.index,
    name = item.name,
    base = item.base,
    sides = item.sides,
    modifier = item.modifier,
    amount = 1,
    value = item.value,
    rarity = item.rarity
  })

  return item
end

function Entity:new(p)
  self.items = p.items
  self.max = 20
  self.count = 0
end

function Entity:upgrade(max)
  self.max = self.max + max
end

function Entity:dump()
  local money = 0

  for i, item in ipairs (self.items) do
    money = money + item.value
    table.remove(self.items, i)
    self.count = self.count - 1
  end

  return money
end

function Entity:create(resources)
  if self.count >= self.max then
    return false
  end

  choice = materialChoices[math.random(1, 4)]
  item = equipmentChoices[math.random(1, 2)]

  result = resources:remove(choice, cost[item])

  if result >= cost[item] then
    creation = equipment[item][choice]
    createdItem = insertItem(self.items, {
      id = inventoryId,
      index = inventoryCount + 1,
      name = '' .. choice .. ' ' .. item .. '',
      base = creation.base,
      sides = math.random(creation.sides.min, creation.sides.max),
      modifier = creation.modifier,
      value = creation.value,
      rarity = creation.rarity
    })

    self.count = self.count + 1
    inventoryId = inventoryId + 1
    inventoryCount = inventoryCount + 1
    return "" .. createdItem.name ..
           " " .. createdItem.base ..
           "d" .. createdItem.sides ..
           "+" .. createdItem.modifier .. ""
  end

  return false
end

function Entity:update(dt)
  -- todo
end

function Entity:draw()
  height = love.graphics.getHeight()
  width = love.graphics.getWidth()
  iterations = 0

  love.graphics.setColor(255, 255, 255)
  love.graphics.printf(
    "Inventory: " .. self.count .. "/" .. self.max .. "",
    288,
    16,
    width
  )

  for i, item in reversedipairs(self.items) do
    iterations = iterations + 1
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(
      "" .. item.name ..
      " " .. item.base ..
      "d" .. item.sides ..
      "+" .. item.modifier .. "",
       -16,
        height - 104 - (iterations * 24),
        width,
        "right"
    )
  end
end

return Entity
