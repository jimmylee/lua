Object = require 'vendor/classic'
Projectiles2 = Object:extend()

local BULLET_SPEED = 200

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    local y = 0
    local x = 0
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.current = 0
 
    return animation
end

function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end

function Projectiles2:new()
    self.mounted = {}
    self.animation = newAnimation(love.graphics.newImage("assets/weapon2.png"), 116.5, 115.5, 1)
    self.cooldown = { max = 1.7, elapsed = 0 }
    self.canShoot = true
end

function Projectiles2:shoot(sourceEntity, targetEntity)
    local target = copy1(targetEntity)
    local source = copy1(sourceEntity)

    local sx = source.x + source.width / 2
    local sy = source.y + source.height / 2

    local tx = target.x
    local ty = target.y

    local angle = math.atan2(( ty - sy ), (tx - sx))

    local projectileProperties = {
        x = sx,
        y = sy,
        angle = angle
    }

    table.insert(self.mounted, projectileProperties)
    self.canShoot = false
end

function Projectiles2:update(dt, target)
    if not self.canShoot then
        self.cooldown.elapsed = self.cooldown.elapsed + dt

        if self.cooldown.elapsed >= self.cooldown.max then
            self.cooldown.elapsed = self.cooldown.elapsed - self.cooldown.max
            self.canShoot = true
        end
    end

    self.animation.current = self.animation.current + dt

    if self.animation.current >= self.animation.duration then
        self.animation.current = self.animation.current - self.animation.duration
    end

    for i,v in pairs(self.mounted) do
        local dx = BULLET_SPEED * math.cos(v.angle)
        local dy = BULLET_SPEED * math.sin(v.angle)
        v.x = v.x + (dx * dt)
        v.y = v.y + (dy * dt)
        
        if v.x > love.graphics.getWidth() or
           v.y > love.graphics.getHeight() or
           v.x < 0 or
           v.y < 0 then
          table.remove(self.mounted, i)
        end
    end
end

function Projectiles2:draw()
    for i,v in pairs(self.mounted) do
        local spriteNum = math.floor(self.animation.current / self.animation.duration * #self.animation.quads) + 1

        love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], v.x, v.y, 0, 1)
    end
end

return Projectiles2