--Lua is the moon  in Brazil
--   # // 

--[[
     Love2d which is a game engine
]]

--global variable
hello = "hello"

--local variables = only inside of the file or function
local world = "world!"

--Function
--def name(arguments):
--public void name(DataType arugments){}
--function name(aruments){}
function name(arguments)
     print(arguments)
end

name(arguments)
name(hello .. world) --concatenating variables into one variable

--If statement
if world=='world' then        --python : java {}
     print('world')   
--else if  conditional then
     --do something
else
     print('hello!')
end

--LOOPS
--while loop to count something
local i=10
while i>0 do          --python :  Java {}
     --note the lack of -= and +=
     i=i-1
     print(i)
end

--for loop
--for localvariable=startingValue, endingValue, stepAmount
--for(int i=0,i<lengthOfYourList,i++){}
--for i in range(len(list)):
for j=10, 1, -1 do
     print(j)
end


--repeat (do-while) loop
local i=10          --redefined instead of reset
repeat
     i=i-1
     print(i)
until i==0
