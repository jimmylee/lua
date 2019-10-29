local config = require('lib.config')
local Ground = require('entities.ground')

local insert = table.insert
local tile   = config.tile

return function(ys)
  local grounds = {}

  for i = 1, #ys, 1 do
    local l, r = ys[i], ys[i % #ys + 1]
    local x = (i - 1) * tile.w
    local y = min(l, r)
    insert(grounds, Ground({ l = l, r = r, x = x, y = y }))
  end

  -- insert(grounds, Ground({ l = l, r = r, x = 16, y = 16 }))

  return grounds
end
