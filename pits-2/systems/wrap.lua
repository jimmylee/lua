local config = require('lib.config')
local tiny   = require('vendor.tiny')

local width = config.map.width

local function Wrap(res)
  local world   = res.world
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('wrap')
  local player

  function system:onAdd(e)
    if e.player then player = e end
  end

  function system:process(e)
    local ex, ey, px = e.pos.x, e.pos.y, player.pos.x

    if ex < px - width/2 then
      world.move(e, ex + width, ey, true)
    elseif ex > px + width/2 then
      world.move(e, ex - width, ey, true)
    end
  end

  return system
end

return Wrap
