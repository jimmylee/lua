math.randomseed(os.time())

local Activity = require 'objects/activity'
local Resources = require 'objects/resources'
local Inventory = require 'objects/inventory';
local Player = require 'objects/player';

local elapsed = 0
local duration = 0.075

local function randomSelectResource()
  eventValue = math.random(1, 26)

  local result = ({
    [1]="copper",
    [2]="copper",
    [3]="copper",
    [4]="copper",
    [5]="copper",
    [6]="bone",
    [7]="bone",
    [8]="bone",
    [9]="bone",
    [10]="bone",
    [11]="bone",
    [12]="bone",
    [13]="bone",
    [14]="bone",
    [15]="bone",
    [16]="wood",
    [17]="wood",
    [18]="wood",
    [19]="wood",
    [20]="wood",
    [21]="wood",
    [22]="wood",
    [23]="wood",
    [24]="wood",
    [25]="wood",
    [26]="iron"
  })[eventValue];

  return result
end

function love.load()
  font = love.graphics.newFont("Masuria.ttf", 20)
  love.graphics.setFont(font)

  viewer = Player({
    gold = 200
  })

  activity = Activity({
    items = {}
  })

  resources = Resources({
    items = {}
  })

  inventory = Inventory({
    items = {}
  })
end

function love.update(dt)

  elapsed = elapsed + dt
  if elapsed < duration then
    return false
  end

  if elapsed >= duration then
    elapsed = elapsed - duration
  end

  eventValue = math.random(1, 1000)
  text = "Adventurer: I found nothing."
  picked = false

  if picked ~= true then
    if eventValue >= 995 then
      text = "Merchant: I came to bring your stock to the king."
      sellEvent = viewer:sell(inventory)

      if sellEvent == false then
        text = "Merchant: I came to bring your stock to the king, but you have nothing for sale."
      end
      if sellEvent == true then
        text = "Merchant: I came to bring your stock to the king, thank you for selling me your goods."
      end

      picked = true
    end
  end

  if picked ~= true then
    if eventValue >= 920 then
      text = "Blacksmith: I tried to create something."
      createEvent = inventory:create(resources)
      if createEvent == false then
        text = "Blacksmith: I failed to create an item."
      end
      if createEvent ~= false then
        text = "Blacksmith: I created a " .. createEvent .. "."
      end

      picked = true
    end
  end

  if picked ~= true then
    if (eventValue >= 700) then
      found = randomSelectResource()
      text = "Adventurer: I found a valuable resource, I found " .. found .. "."
      resources:add(found, 1)
      picked = true
    end
  end

  activity:update(dt, text)
  resources:update(dt)
  inventory:update(dt)
  viewer:update(dt)
end

function love.draw()
  activity:draw()
  resources:draw()
  inventory:draw()
  viewer:draw()
end
