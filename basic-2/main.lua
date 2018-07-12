function love.load()

end

function love.update(dt)

end

-- draws every single frame
function love.draw()
    -- Gets the x- and y-position of the mouse.
    local x, y = love.mouse.getPosition()
    
    -- Draws the position on screen.
    love.graphics.print("The mouse is at (" .. x .. "," .. y .. ")", 24, 24)
    love.graphics.print("Press a key to move the mouse to a random point", 24, 48);
    love.graphics.print("Press a key to track which mouse button is down", 24, 72);

    -- left
    if love.mouse.isDown(1) then
        love.graphics.print("Left mouse button is down", 50, 110);
    end

    -- right
    if love.mouse.isDown(2) then
        love.graphics.print("Right mouse button is down", 50, 110);
    end
end

-- press a key to move the mouse to some random point
function love.keypressed(k) 
    local x, y = math.random(0, 800), math.random(0, 600)
    -- noop love.mouse.setPosition(x, y)
end