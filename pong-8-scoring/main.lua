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

     love.window.setTitle("Pong")

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
     playerLeft = Paddle(10,30,5,50)
     playerRight = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 50)
     
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
          --[[
               detech ball collision with paddles,
                    --increase the speed
                    --move the ball outside of the paddle
                    --keep velocity going in the same direction, but randomize a wittle
               detech ball collision with border,
                    keep the x velocity constant
                    y velocity flipped direction (*-1)
          ]]

          --collide with playerLeft
          if ball:collides(playerLeft) then
               ball.dx = -ball.dx * 1.03
               ball.x = playerLeft.x + 5
               if ball.dy < 0 then
                    ball.dy= -math.random(10,150)
               else
                    ball.dy= math.random(10,150)
               end
          end

          --collide with playerRight
          if ball:collides(playerRight) then
               ball.dx = -ball.dx * 1.03    
               ball.x = playerRight.x - 4         
               if ball.dy < 0 then
                    ball.dy = -math.random(10,150)
               else 
                    ball.dy = math.random(10,150)
               end
          end
          --top wall collision
          if ball.y<0 then
               ball.dy=-ball.dy
               ball.y=0
          end

          --bottom wall collision
          if ball.y >= VIRTUAL_HEIGHT-4 then
               ball.y=VIRTUAL_HEIGHT-4
               ball.dy=-ball.dy
          end

          --when ball goes past a paddle
          if ball.x < 0  then
               ball:reset()
               gameState='start'
               playerRightScore = playerRightScore + 1
          end
          if ball.x > VIRTUAL_WIDTH  then
               ball:reset()
               gameState='start'
               playerLeftScore = playerLeftScore + 1
          end

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

     --call displayFPS()
     displayFPS()

     --end rendering at virtual resolution
     push:apply('end')
end

--display frame per second (not first person shooter)
function displayFPS()
     love.graphics.setFont(smallFont)
     love.graphics.setColor(255,0,0,255)
     love.graphics.print("FPS: "..tostring(love.timer.getFPS()),10,10)
end