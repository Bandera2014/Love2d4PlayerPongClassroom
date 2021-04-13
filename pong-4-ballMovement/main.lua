push = require 'push'

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
     
     --paddle positions on the Y axis
     playerLeftY = 30
     playerRightY = VIRTUAL_HEIGHT-50
     
     --ball starting x and y
     ballX = VIRTUAL_WIDTH/2-2
     ballY = VIRTUAL_HEIGHT/2-2
     
     --ball's direction
     --math.random 
     ballDX = 0--math.random(2) == 1 and 100 or -100          --one liner if statement
     -- if it is 1, we're going to use 100, if it isn't -100
     ballDY = 0--math.random(-50,50)
     
     gameState = 'start'

     
end

function love.update(dt)
     --left player movement
     -- left player or player 1
     if love.keyboard.isDown("w") then
          playerLeftY = math.max(0,playerLeftY + -PADDLE_SPEED*dt)
     elseif love.keyboard.isDown("s") then
          playerLeftY = math.min(VIRTUAL_HEIGHT-20,playerLeftY + PADDLE_SPEED*dt)
     end

     --right player movement
     -- player 2 movement
     if love.keyboard.isDown('up') then
          -- add negative paddle speed to current Y scaled by deltaTime
          playerRightY = math.max(0,playerRightY + -PADDLE_SPEED*dt)
     elseif love.keyboard.isDown('down') then
          -- add positive paddle speed to current Y scaled by deltaTime
          playerRightY = math.min(VIRTUAL_HEIGHT-20,playerRightY + PADDLE_SPEED*dt)
     end

     --ball movement
     ballX = ballX + ballDX * dt
     ballY = ballY + ballDY * dt

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
               ballX = VIRTUAL_WIDTH/2-2
               ballY = VIRTUAL_HEIGHT/2-2
               ballDX = math.random(2) == 1 and 100 or -100          --one liner if statement
               ballDY = math.random(-50,50)
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

     --ball
     love.graphics.rectangle('fill',ballX,ballY,4,4)
     --playerLeft    start in the top left
     love.graphics.rectangle('fill',10,playerLeftY,5,20)
     --playerRight   start in the bottom right
     love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10, playerRightY, 5, 20)


    --end rendering at virtual resolution
     push:apply('end')
end