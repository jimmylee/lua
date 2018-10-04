Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:new(properties)
    self.asset = love.graphics.newImage(properties.imagePath)
    self.x = properties.x
    self.y = properties.y
    self.width = properties.width
    self.height = properties.height
    self.animation = {}
    self.animation.duration = 1
    self.animation.elapsed = 0
end

function Entity:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - 100 * dt
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + 100 * dt
    end

    if love.keyboard.isDown("up") then
        self.y = self.y - 100 * dt
    end

    if love.keyboard.isDown("down") then
        self.y = self.y + 100 * dt
    end
end

function Entity:draw()
    love.graphics.draw(self.asset, self.x, self.y)
end

return Entity