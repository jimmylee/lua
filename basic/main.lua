function love.load()
    image = love.graphics.newImage('assets/test.jpg')
end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(image, love.math.random(0, 800), love.math.random(0, 600))
end