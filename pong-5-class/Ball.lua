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
     self.ballDX = math.random(2) == 1 and 100 or -100          --one liner if statement
     -- if it is 1, we're going to use 100, if it isn't -100
     self.ballDY = math.random(-50,50)

end

function Ball:update(dt)
     --self tells the program which object we're talking about
     --ball movement
     self.x = self.x + self.ballDX * dt
     self.y = self.y + self.ballDY * dt
end

function Ball:render()
     love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
end

function Ball:reset()
     self.x = VIRTUAL_WIDTH / 2 - 2
     self.y = VIRTUAL_HEIGHT / 2 - 2
     self.ballDX = math.random(2) == 1 and -100 or 100
     self.ballDY = math.random(-50, 50)
end