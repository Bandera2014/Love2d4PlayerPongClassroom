--Java:        public Class FileName{}
--Python:      Class FileName
Ball = Class{}

--Java:   public NameOfClass(){}
--Python: def __init__(self):
function Ball:init(x,y,width,height)
     self.x = x
     self.y = y
     self.width = width
     self.height = height

     --ball's direction
     --math.random 
     self.dx = math.random(2) == 1 and 100 or -100          --one liner if statement
     -- if it is 1, we're going to use 100, if it isn't -100
     self.dy = math.random(-50,50)
     -- self.dy = 270

end

function Ball:update(dt)
     --self tells the program which object we're talking about
     --ball movement
     self.x = self.x + self.dx * dt
     self.y = self.y + self.dy * dt
end

function Ball:render()
     love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
end

function Ball:reset()
     self.x = VIRTUAL_WIDTH / 2 - 2
     self.y = VIRTUAL_HEIGHT / 2 - 2
     self.dx = math.random(2) == 1 and -100 or 100
     self.dy = math.random(-50, 50)
end

function Ball:collides(paddle)
     --return true or false that there is a collision

     --check for y collision
     -- if ball is beneath                  or  ball is above
     if (self.y > (paddle.y+paddle.height)) or (paddle.y>self.y+self.height) then
          return false
     end

     --check for x collision
     --checking to see if I collided with the paddles
     if self.x > (paddle.x + paddle.width) or paddle.x > (self.x + self.width) then
          return false
     end

     return true

end