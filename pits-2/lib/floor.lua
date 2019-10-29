local config = require('lib.config')

local insert = table.insert
local ceil, pi, random, sin = math.ceil, math.pi, math.random, math.sin

local width, tile = config.map.width, config.tile

local DEFAULT_WORLD = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1},
  {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

return function()
  local ys = {}

  for x = 0, width - tile.w, tile.w do
    print(x)
    insert(ys, 0)
  end

  return ys
end
