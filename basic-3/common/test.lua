Object = require 'vendor/classic'
Test = Object:extend()

function Test:draw()
  love.graphics.print("I am drawing on the screen.", 24, 24)
end

return Test