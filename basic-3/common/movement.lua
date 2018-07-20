Object = require 'vendor/classic'
Movement = Object:extend()

function Movement:doSchemeOne(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 10 * dt
    coordinates.y = entity.y + diffY / 10 * dt

    return coordinates
end

function Movement:doSchemeTwo(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 5 * dt
    coordinates.y = entity.y + diffY / 5 * dt

    return coordinates
end

function Movement:doSchemeThree(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 7 * dt
    coordinates.y = entity.y + diffY / 7 * dt

    return coordinates
end

return Movement