local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'
local Projectiles2 = require 'common/projectiles2'

function love.load()
    hero = Entity({
        width = 32,
        height = 48,
        x = 400,
        y = 400,
        imagePath = '/assets/entity.png'
    })

    enemy = Opponent({
        width = 64,
        height = 108,
        x = 400,
        y = 24,
        imagePath = '/assets/opponent.png'
    })

    weapon = Projectiles()
    weapon2 = Projectiles2()
end

function love.update(dt)
    hero:update(dt)
    enemy:update(dt, hero)

    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()

        if weapon.canShoot then
            weapon:shoot(hero, { 
                x = x, 
                y = y, 
                width = 2, 
                height = 2 
            })
        end
    end

    if (weapon2.canShoot) then
        weapon2:shoot(enemy, hero)
    end

    weapon:update(dt)
    weapon2:update(dt)
end

function love.draw()
    hero:draw()
    enemy:draw()
    weapon:draw()
    weapon2:draw()
end