# Love2d4PlayerPongClassroom
You and Bander will be venturing back into time and develop the famous Pong utilizing Love2d and Lua.  We'll practice some version control in this assignment.  We'll build the basic retro 2 player version, but after that, you'll be required to make this a little more advanced and build out a 4 player version.  Yes, it will be pure chaos.  Go ahead and create the different directories required (listed below).  I also have a link posted to where to download Love2d.  We'll need to use an older version for our code to work.  

## Installing Love2d
- [ ] [Love2d Download](https://github.com/love2d/love/releases/download/0.10.2/love-0.10.2-win64.exe)

- [ ] After you download and install the package, you will need to set up 'Love' into your path so Powershell knows what we are talking about. Here is a wiki page and a YouTube video on how to do this.
    - [Wiki](https://love2d.org/wiki/PATH)
    - [Video](https://www.youtube.com/watch?v=gb9e3m98avk&ab_channel=TheCuriousCoder)


## List of Directories
 - [X] pong0-helloworld
 - [X] pong1-retroGraphics
 - [X] pong2-paddleBallSetup
 - [X] pong3-paddleMovement
 - [X] pong4-ballMovementPlusStart
 - [X] pong5-classes
 - [X] pong6-fps
 - [X] pong7-collision
 - [X] pong8-scoring
 - [X] pong9-serving
 - [X] pong10-victory
 - [X] pong11-sound
 - [X] pong12-resize
 - [ ] pong13-PVC
 - [ ] pong14-4PlayerVersion
 - [ ] pong15-4computerVScomputer





# Assignment
Take our completed version of Pong built with Lua and add in 4 player pong.
- No more boundaries, but you will have a paddle for each side of the field.
- The scoring situation will stay the same whereas if the ball goes past the paddle, the other player scores a point. Instead of keeping track of who hit the ball last before it goes past the opponents paddle, but have it where each player starts with 7 points. Each time, the ball goes past their paddle, they lose a point.
- Whoever was scored on gets to serve the ball. When the ball is in the serve state, it needs to serve the ball to the opposite paddle.
- Make sure that the serve message states the correct paddle.
- The game is over once 1 person loses all 7 points (You will need to update the victory statem).
- For a challenge and some bonus points, start the ball on the paddle of the serve, and serve the ball from the paddle.
- For another challenge and some bonus points, if one paddle scores 3 times in a row, its paddle speed decreases.
- For even more bonus points, do a litle research and put the game on an Android Device