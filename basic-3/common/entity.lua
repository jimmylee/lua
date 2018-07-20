Object = require 'vendor/classic'
Entity = Object:extend()

function Entity:create(imagePath)
    local entity_object = {};
    entity_object.asset = love.graphics.newImage(imagePath) 
    entity_object.x = 0
    entity_object.y = 0
    entity_object.width = 64
    entity_object.height = 108
    entity_object.animationDuration = 1
    entity_object.animationElapsed = 0

    return entity
end

return Entity