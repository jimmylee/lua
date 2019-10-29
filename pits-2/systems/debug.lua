local config = require('lib.config')
local tiny   = require('vendor.tiny')

local format = string.format
local getFPS, graphics = love.timer.getFPS, love.graphics

local h = config.camera.window.h

local debug = [[
  FPS: %.0f
  Player.X: %.1f
  Player.Y: %.1f
]]

local function Debug()
  local system  = tiny.processingSystem({ hud = true })
  system.filter = tiny.requireAll('player')
  system.active = true

  function system:process(e)
    local pos = e.pos
    graphics.setColor(255, 255, 255, 150)

    -- camera window
    local cx, cy = love.graphics:getWidth()/2, love.graphics.getHeight()/2
    local t, b = cy - 2*h/3, cy + h/3
    graphics.line(cx, t, cx, b)
    graphics.line(cx - 10, t, cx + 10, t)
    graphics.line(cx - 10, b, cx + 10, b)

    -- debug output
    local output = format(debug, getFPS(), pos.x, pos.y)
    graphics.print(output, 10, 10)
  end

  return system
end

return Debug
