-- Coordinate System (0,0) = Top Left
--no more importing stuff from LOVE
--Game Loop:  process input, update the information, render the screen

push = require 'push'  --similar to JS to import classes

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


--a function to start up the window and initalizes the game
function love.load()
     --nearest-neightbor filtering on upscaling and downscaling to prevent blurriness
     love.graphics.setDefaultFilter('nearest','nearest')

     --initalized our virtual resolution, which is rendered inside of our actual window
     push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
          fullscreen=false,
          resizable=false,
          vsync=true
     })
end


--update the screen

--key pressed:  looking for keyboard keys being pressed
function love.keypressed(key)
     --keys can be accessed by string name
     if key == 'escape' then
          love.event.quit()
     end
end

--render the screen with information:  draw anything that is needed
function love.draw()
     --begin rendering a virtual resolution
     push:apply('start')

     love.graphics.printf(
          'Hello Pong!',      --text to render
          0,            --starting X (0 since we're going to center it based on the window)
          VIRTUAL_HEIGHT/2, --starting Y (halfway down the screen)
          VIRTUAL_WIDTH,   --number of pixels to center within
          'center'            --alignment
     )

     --end rendering at virtual resolution
     push:apply('end')
end
