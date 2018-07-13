function createMovementSchemeOne(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 10 * dt
    coordinates.y = entity.y + diffY / 10 * dt

    return coordinates
end

function createMovementSchemeTwo(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 5 * dt
    coordinates.y = entity.y + diffY / 5 * dt

    return coordinates
end

function createMovementSchemeThree(entity, dt)
    local diffX = x - entity.x
    local diffY = y - entity.y

    local coordinates = {}
    coordinates.x = entity.x + diffX / 7 * dt
    coordinates.y = entity.y + diffY / 7 * dt

    return coordinates
end

function newEntity(imagePath)
    local entity = {};
    entity.asset = love.graphics.newImage(imagePath) 
    entity.x = 0
    entity.y = 0
    entity.width = 64
    entity.height = 108
    entity.animationDuration = 1
    entity.animationElapsed = 0

    return entity
end

function love.load()
    chaser = newEntity("/assets/chaser.png")
    chaserTwo = newEntity("/assets/chaser2.png")
    chaserThree = newEntity("/assets/chaser3.png")

    character = love.graphics.newImage("assets/cursor.png")

    -- mouse is hidden for this experience
    love.mouse.setVisible(false)

    BULLET_SPEED = 250;

    x = 500
    y = 500
    bullets = {}
end

function love.update(dt)
    local chaserOneNextMovement = createMovementSchemeTwo(chaser, dt);
    local chaserTwoNextMovement = createMovementSchemeOne(chaserTwo, dt);
    local chaserThreeNextMovement = createMovementSchemeThree(chaserThree, dt);

    chaser.x = chaserOneNextMovement.x
    chaser.y = chaserOneNextMovement.y

    chaserTwo.x = chaserTwoNextMovement.x
    chaserTwo.y = chaserTwoNextMovement.y

    chaserThree.x = chaserThreeNextMovement.x
    chaserThree.y = chaserThreeNextMovement.y

    if love.keyboard.isDown("left") then
        x = x - 100 * dt
    end

    if love.keyboard.isDown("right") then
        x = x + 100 * dt
    end

    if love.keyboard.isDown("up") then
        y = y - 100 * dt
    end

    if love.keyboard.isDown("down") then
        y = y + 100 * dt
    end

    chaser.animationElapsed = chaser.animationElapsed + dt
    if chaser.animationElapsed >= chaser.animationDuration then
      chaser.animationElapsed = chaser.animationElapsed - chaser.animationDuration
      local startX = chaser.x + chaser.width / 2
      local startY = chaser.y + chaser.height / 2
      
      local targetX = x
      local targetY = y
      
      local angle = math.atan2((targetY - startY), (targetX - startX))
      
      local newBullet = {
        x = startX,
        y = startY,
        angle = angle
      }
      table.insert(bullets, newBullet)
    end

    for i,v in pairs(bullets) do
        local Dx = BULLET_SPEED * math.cos(v.angle)
        local Dy = BULLET_SPEED * math.sin(v.angle)
        v.x = v.x + (Dx * dt)
        v.y = v.y + (Dy * dt)
        
        if v.x > love.graphics.getWidth() or
           v.y > love.graphics.getHeight() or
           v.x < 0 or
           v.y < 0 then
          table.remove(bullets, i)
        end
    end
end

function love.draw()
    love.graphics.draw(chaser.asset, chaser.x, chaser.y)
    love.graphics.draw(chaserTwo.asset, chaserTwo.x, chaserTwo.y)
    love.graphics.draw(chaserThree.asset, chaserThree.x, chaserThree.y)

    love.graphics.draw(character, x, y)

    love.graphics.setColor(1, 0, 0)

    for i,v in pairs(bullets) do
      love.graphics.circle("fill", v.x, v.y, 4,4)
    end

    love.graphics.setColor(1, 1, 1)
end