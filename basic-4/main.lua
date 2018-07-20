local Entity = require 'common/entity' 
local Opponent = require 'common/opponent'
local Projectiles = require 'common/projectiles'

function love.load()
    hero = Entity({
        width = 32,
        height = 48,
        x = 0,
        y = 0,
        imagePath = '/assets/entity.png'
    })

    enemy = Opponent({
        width = 64,
        height = 108,
        x = 0,
        y = 0,
        imagePath = '/assets/opponent.png'
    })

    weapon = Projectiles({
        mounted = {}
    })
end

function love.update(dt)
    hero:update(dt)
    enemy:update(dt, hero)
    weapon:shoot(hero, enemy)
    weapon:shoot(enemy, hero)
    weapon:update(dt)
end

function love.draw()
    hero:draw()
    enemy:draw()
    weapon:draw()
end