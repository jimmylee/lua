local monsterX = 0
local monsterY = 0

local monsterTwoX = 0
local monsterTwoY = 0
local monsterTwoAngle = 0

local monsterFourX = 0
local monsterFourY = 0
local monsterFourAngle = 0

text = [[
   Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation
ullamco laboris nisi  ut aliquip ex ea commodo  consequat.
Duis aute irure dolor in  reprehenderit  in voluptate velit
esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt  in culpa qui officia
deserunt mollit anim id est laborum.
   Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation
ullamco laboris nisi  ut aliquip ex ea commodo  consequat.
Duis aute irure dolor in  reprehenderit  in voluptate velit
esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt  in culpa qui officia
deserunt mollit anim id est laborum.
]]

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
    animation.currentTime = 0
 
    return animation
end

function love.load()
    love.mouse.setVisible(true);

    -- not sure what font this picks, must be some library thing.
    -- love.graphics.setFont(love.graphics.newFont(11))
    local f = love.graphics.newFont("assets/MaisonNeue-Bold.ttf")
    love.graphics.setFont(f)

    -- loader
    cursor = love.mouse.newCursor(love.image.newImageData("assets/cursor.png"), 0, 0)
    love.mouse.setCursor( cursor )

    -- animation
    animation = newAnimation(love.graphics.newImage("assets/anim-boogie.png"), 32, 32, 1)
    animationTwo = newAnimation(love.graphics.newImage("assets/anim-boogie.png"), 32, 32, 1)

    monster = love.graphics.newImage("assets/kraken.png")
    monsterTwo = love.graphics.newImage("assets/kraken.png")
    monsterThree = love.graphics.newImage("assets/kraken.png")
    monsterFour = love.graphics.newImage("assets/kraken.png")
end

function love.update(dt)
    -- I don't see the need for a timer yet but maybe someone can explain.
    -- love.timer.sleep(0.01)

    -- kinda lame management here
    animation.currentTime = animation.currentTime + dt
    animationTwo.currentTime = animationTwo.currentTime + dt

    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end

    if animationTwo.currentTime >= animationTwo.duration then
        animationTwo.currentTime = animationTwo.currentTime - animationTwo.duration
    end

    monsterTwoAngle = (monsterTwoAngle + dt) % (2 * math.pi)
    monsterTwoX, monsterTwoY = 400 + math.cos(monsterTwoAngle)*100, 300 + math.sin(monsterTwoAngle)*100

    monsterFourAngle = monsterFourAngle + dt
    monsterFourX, monsterFourY = 400 + math.cos(monsterFourAngle)*100, 300 + math.sin(monsterFourAngle)*100


    if love.keyboard.isDown("left") then
        monsterX = monsterX - 200 * dt * 4
    end

    if love.keyboard.isDown("right") then
        monsterX = monsterX + 200 * dt * 4
    end

    if love.keyboard.isDown("up") then
        monsterY = monsterY - 200 * dt * 4
    end

    if love.keyboard.isDown("down") then
        monsterY = monsterY + 200 * dt * 4
    end
end

-- draws every single frame
function love.draw()
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 24, 24 * 9, 0, 1)

    local spriteNumTwo = math.floor(animationTwo.currentTime / animationTwo.duration * #animationTwo.quads) + 1
    love.graphics.draw(animationTwo.spriteSheet, animationTwo.quads[spriteNum], 48, 24 * 9, 0, 1)

    -- Gets the x- and y-position of the mouse.
    local x, y = love.mouse.getPosition()
    
    -- Draws the position on screen.
    love.graphics.print("The mouse is at (" .. x .. "," .. y .. ")", 24, 24)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 24, 24 * 2)
    love.graphics.print("DT: " .. love.timer.getDelta(), 24, 24 * 3)

    love.graphics.print("Press b to move the mouse to a random point", 24, 24 * 4)
    love.graphics.print("Click the mouse button to show tracking", 24, 24 * 5)

    -- left
    if love.mouse.isDown(1) then
        love.graphics.print("Left mouse button is down", 24, 24 * 6)
    end

    -- right
    if love.mouse.isDown(2) then
        love.graphics.print("Right mouse button is down", 24, 24 * 6)
    end

    love.graphics.print("Press v to toggle the mouse cursor", 24, 24 * 7)

    if love.keyboard.isDown("return") then
        love.graphics.print("The return key is down. Press it to put it down.", 24, 24 * 8)
    else
        love.graphics.print("The return key isn't down. Release the key.", 24, 24 * 8)
    end

    love.graphics.print(text, 24, 24 * 12)

    love.graphics.draw(monster, monsterX, monsterY)

    love.graphics.draw(monsterTwo, monsterTwoX, monsterTwoY, monsterTwoAngle)

    love.graphics.draw(monsterThree, x, y)

    local monsterFourROT = monsterFourAngle * 180 / math.pi
    local monsterFourSX = math.cos(monsterFourAngle) * 3
    local monsterFourSY = math.sin(monsterFourAngle) * 2
    love.graphics.draw(monsterFour, monsterFourX, monsterFourY, monsterFourROT, monsterFourSX, monsterFourSY, 254, 126)
end

-- press a key to move the mouse to some random point
function love.keypressed(k) 
    if k == "v" then
        if love.mouse.isVisible() then
            love.mouse.setVisible(false)
        else
            love.mouse.setVisible(true)
        end
    end

    if k == "b" then
        local x, y = math.random(0, 800), math.random(0, 600)
        love.mouse.setPosition(x, y)

        -- ensures weird monster cursor
        love.mouse.setCursor( cursor )
    end
end