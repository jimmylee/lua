function newAnimation(image, width, height)
  -- Lua as a programming language supports local variables.
  -- Unlike global variables, local variables have 
  -- their scope limited to the block they are declared.
  -- In this case, `newAnimation` is considered a `block`.
  -- Canonically, a block is the body of a control 
  -- structure, in this case a function.
  local animation = {}
  -- A table in Lua is an object in more than one sense.
  -- We can store state in this object.
  animation.spriteSheet = image;
  animation.quads = {};
  local y = 0
  local x = 0
 
  -- We can use the dimensions of the image we're providing. 
  -- explosions.png is a 512x512 image.
  -- Since there are 4 rows and 4 columns, 
  -- each quadrant is 128px width, and 128px height.
  -- Below is the syntax for a for loop.
  -- We use the four loop to insert each part of the 
  -- sprite sheet into a Lua table.
  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      -- The purpose of a Quad is to use a fraction 
      -- of an image to draw objects, as opposed to 
      -- drawing entire image.
      table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end
 
  -- These are some values that represent how long 
  -- we should spend in each frame of the sprite sheet animation.
  animation.duration = 1
  animation.current = 0
 
  return animation
end

-- This local variable helps us keep track of all 
-- of the entities we want to animate.
-- It can be used in other blocks.
local mounted = {}
-- This function is called exactly once at 
-- the beginning of the game.
function love.load()
  -- You can use any values you like here.
  -- I am going to initialize 20 explosions 
  -- by inserting 20 local variables
  -- into a table.
  for i = 0, 20, 1 
  do 
   local explosion = newAnimation(
     love.graphics.newImage("explosion.png"),
     128,
     128
   )
   table.insert(mounted, explosion)
  end
end

-- Callback function used to update the 
-- state of the game every frame.
function love.update(dt)
  -- Iterate over each of the explosions in the table.
  for i, v in pairs(mounted) do
    -- For each explosion, 
    -- update the animation duration of the frame.
    mounted[i].current = mounted[i].current + dt
    -- If the current duration is greater than the max duration
    -- Reset the duration.
    if mounted[i].current >= mounted[i].duration then
      mounted[i].current = 0
    end
  end
end

-- Callback function used to draw on the screen every frame.
function love.draw()
  -- Iterate over each of the explosions in the table.
  for i, v in pairs(mounted) do
    -- This is just to make it easier to reference the explosion.
    local currentExplosion = mounted[i]
    -- Which sprite we are going to animate.
    local spriteNum = math.floor(
      currentExplosion.current / currentExplosion.duration * #currentExplosion.quads
    ) + 1
    -- Get the dimensions of your current screen.
    local width, height = love.graphics.getDimensions()
    -- Draw one of the explosions.
    love.graphics.draw(
      currentExplosion.spriteSheet, 
      currentExplosion.quads[spriteNum], 
      math.random(0, width), 
      math.random(0, height)
    )
  end
end