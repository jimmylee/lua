local tiny = require('vendor.tiny')

local function Inputs()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls', 'inputs')

  function love.keypressed(key)
    for _, e in ipairs(system.entities) do
      for ctrl, mapping in pairs(e.inputs.actions) do
        if key == mapping then table.insert(e.controls.actions, ctrl) end
      end
    end
  end

  function system:onAdd(e)
    e.controls = {
      actions = {},
      states  = {}
    }
  end

  function system:process(e)
    for ctrl, mapping in pairs(e.inputs.states) do
      e.controls.states[ctrl] = love.keyboard.isDown(mapping)
    end
  end

  return system
end

return Inputs
