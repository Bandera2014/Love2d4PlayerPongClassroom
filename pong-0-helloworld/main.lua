-- Coordinate System (0,0) = Top Left
--no more importing stuff from LOVE
--Game Loop:  process input, update the information, render the screen

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


--a function to start up the window and initalizes the game
function love.load()
     --                  width(int), height(int), option(map)
     love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
          fullscreen = false,
          resizable = false,
          vsync = true
     })
end
--update the screen

--render the screen with information:  draw anything that is needed
function love.draw()
     love.graphics.printf(
          'Hello Pong!',      --text to render
          0,                  --starting X (0 since we're going to center it based on the window)
          WINDOW_HEIGHT/2,    --starting Y (halfway down the screen)
          WINDOW_WIDTH,       --number of pixels to center within
          'center'            --alignment         
     )
end
