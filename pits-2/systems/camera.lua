local config = require('lib.config')
local filter = require('lib.filter')
local tiny   = require('vendor.tiny')

local tile, window = config.tile, config.camera.window

local function Camera(res)
  local camera, world = res.camera, res.world
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('camera')

  function system:process(e, dt)
    local pos, size, state = e.pos, e.size, e.state

    local dx = pos.x + size.w/2 - camera.x
    local dy = 0

    local ct, cb = camera.y - 2*window.h/3, camera.y + window.h/3
    local bottom = pos.y + size.h

    local height = love.graphics.getHeight()
    local ground = world.queryRect(pos.x, pos.y + size.h, size.w, height/2, filter.by('ground'))[1]

    if (ground) then
      local limit = ground.pos.y - height/3 + tile.h
      bottom = bottom > limit and limit or bottom
    end

    if bottom > cb or state:is('running') then
      dy = bottom - cb
    elseif pos.y < ct then
      dy = pos.y - ct
    end

    camera:move(32*dx*dt, 4*dy*dt)
  end

  return system
end

return Camera
