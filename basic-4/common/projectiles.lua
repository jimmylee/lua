Object = require 'vendor/classic'
Projectiles = Object:extend()

local BULLET_SPEED = 250

function Projectiles:new()
    self.mounted = {}
end

function Projectiles:shoot(sourceEntity, targetEntity)
    local sx = sourceEntity.x + sourceEntity.width / 2
    local sy = sourceEntity.y + sourceEntity.height / 2

    local tx = targetEntity.x
    local ty = targetEntity.y

    local angle = math.atan2(( ty - sy ), (tx - sx))

    local projectileProperties = {
        x = sx,
        y = sy,
        angle = angle
    }

    table.insert(self.mounted, projectileProperties)
end

function Projectiles:update(dt, target)
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

function Projectiles:draw()
    love.graphics.setColor(1, 0, 0)
    for i,v in pairs(self.mounted) do
      love.graphics.circle("fill", v.x, v.y, 4, 4)
    end
    -- love.graphics.setColor(1, 1, 1)
end

return Projectiles