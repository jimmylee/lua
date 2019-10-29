require('lib.util').import()
math.randomseed(os.time())

local Gamestate = require('vendor.gamestate')
local Pit = require('states.pit')

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(Pit())
end
