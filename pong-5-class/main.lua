push = require 'push'    --push is the alias or object
Class = require 'class'    --push is the alias or object
require 'Ball'           --we'll create objects later
require 'Paddle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move the paddle; multiplied by dt in updateFunction
--   dt is delta time
PADDLE_SPEED = 200

--A function to start up the window that initialize the game
function love.load()
     --set the randomness
     math.randomseed(os.time())

     --nearest-neightbor filtering on upscaling and downscaling to prevent blurriness
     love.graphics.setDefaultFilter('nearest','nearest')

     --var = module.module.method('filename',fontsize)
     smallFont=love.graphics.newFont('font.ttf',8)
     scoreFont = love.graphics.newFont('font.ttf',32)

     --initalized our virtual resolution, which is rendered inside of our actual window
     push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
          fullscreen=false,
          resizable=false,
          vsync=true
     })

     
     --score values:
     playerLeftScore = 0
     playerRightScore = 0
     
     --paddle initialize
     playerLeft = Paddle(10,30,5,20)
     playerRight = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
     
     --ball initialization
     ball = Ball(VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
     
     gameState = 'start'
end

function love.update(dt)
     --left player movement
     -- left player or player 1
     if love.keyboard.isDown("w") then
          playerLeft.dy = -PADDLE_SPEED
     elseif love.keyboard.isDown("s") then
          playerLeft.dy = PADDLE_SPEED
     else
          playerLeft.dy=0
     end

     --right player movement
     if love.keyboard.isDown("up") then
          playerRight.dy = -PADDLE_SPEED
     elseif love.keyboard.isDown("down") then
          playerRight.dy = PADDLE_SPEED
     else
          playerRight.dy=0
     end

     --ball update movement
     if gameState == 'play' then
          ball:update(dt)
     end

     playerLeft:update(dt)
     playerRight:update(dt)

end

--[[
     Keyboard handling, called by LOVE2D each frame;
          passes in the key we pressed so we can acess.
]]
function love.keypressed(key)
     --keys can be accessed by string name
     if key == 'escape' then
          --functione LOVE gives us to terminate application
          love.event.quit()
     elseif key == 'enter' or key == 'return' then
          --change the state of the game
          if gameState == 'start' then
               gameState = 'play'
          else
               --reset the game
               gameState = 'start'
               ball:reset()
          end
     end
end

--update the screen with information: draw anything that is needed
--function module.draw()
function love.draw()
     --begin rendering a virtual resolution
     push:apply('start')

     --clear the screen with a specific color; in this came, a old looking color
     --not black but dark gray
     --                  R ,G ,B ,A
     love.graphics.clear(40,45,52,255)

     -- draw welcome text toward the top of the screen
     love.graphics.setFont(smallFont)
     if gameState == 'start' then
          love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
     else
          love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
     end


     --setFont to scoreFont
     love.graphics.setFont(scoreFont)
     --printf the scores
     love.graphics.print(tostring(playerLeftScore),VIRTUAL_WIDTH/2-60,VIRTUAL_HEIGHT/3)
     love.graphics.print(tostring(playerRightScore),VIRTUAL_WIDTH/2+60,VIRTUAL_HEIGHT/3)

     --ball rendering
     ball:render()
     --paddle rendering
     playerLeft:render()
     playerRight:render()


    --end rendering at virtual resolution
     push:apply('end')
end