push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--A function to start up the window that initialize the game
function love.load()
     --nearest-neightbor filtering on upscaling and downscaling to prevent blurriness
     love.graphics.setDefaultFilter('nearest','nearest')

     --var = module.module.method('filename',fontsize)
     smallFont=love.graphics.newFont('font.ttf',8)
     love.graphics.setFont(smallFont)

     --initalized our virtual resolution, which is rendered inside of our actual window
     push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
          fullscreen=false,
          resizable=false,
          vsync=true
     })
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
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    --ball
    --                      fill  , start x         , start y          ,w,h
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
    --playerLeft    start in the top left
    love.graphics.rectangle('fill',10,30,5,20)
    --playerRight   start in the bottom right
    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)


    --end rendering at virtual resolution
     push:apply('end')
end