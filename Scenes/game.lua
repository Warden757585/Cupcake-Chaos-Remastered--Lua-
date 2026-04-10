local Cupcake = require("Cupcake")
local Player = require("Player")
local Timer = require("Timer")

local game = {}

local myPlayer
local myTimer
local cupcakeIndex = {}
local seed = 1
-- Font Variable(s):
local mainFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
-- Audio variable(s):
local scoreSound = love.audio.newSource("Assets/Audio/Legacy Audio/score.wav", "static")
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false


function game.load()
    -- Set the current font to mainFont
    love.graphics.setFont(mainFont)
    -- Load all images
    local img_1 = love.graphics.newImage("Assets/Textures/Default Textures/cupcwake.png")
    local img_2 = love.graphics.newImage("Assets/Textures/Default Textures/porple guy.png")
    -- Add the cupcake(s) to the list of cupcakes index
    table.insert(cupcakeIndex, Cupcake.new(350, 250, img_1, seed, scoreSound)) -- Cupcake 1
    table.insert(cupcakeIndex, Cupcake.new(650, 550, img_1, seed, scoreSound)) -- Cupcake 2
    -- Set the timer to have our desired duration. Then we st it running
    myTimer = Timer.new(30)
    myTimer:startCounting()
    -- Declare our player
    myPlayer = Player.new(64, 64, img_2, seed)
    -- Assign each cupcake its own individual seed so that they do not re-position to the same coordinates
    -- Changing the game's seed still affects each cupcake
    for i, cupcake in ipairs(cupcakeIndex) do
        cupcakeIndex[i].seed = cupcakeIndex[i].seed + i * 100200300
    end
end

function game.update(dt)
    myPlayer:playerMovement()
    myPlayer:checkCupcakes(cupcakeIndex)
    myTimer:updateTime(dt)
end

function game.keypressed(key)
	if key == "escape" then
        myTimer:stopCounting()
		return "menu"
	end
    if key == "f3" then
        doDebug = not doDebug
    end
    if key == "f2" then
        doKeyDebug = not doKeyDebug
    end
    if(doKeyDebug) then
        print(key)        
    end
end

function game.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the cupcake and player
    for i, cupcake in ipairs(cupcakeIndex) do
        cupcake:draw()
    end
    myPlayer:draw()
    if love.graphics.getFont() == titleFont then
        love.graphics.setFont(mainFont)
    end
    love.graphics.print("Score: " ..myPlayer.score.. " Speed: " ..myPlayer.speed.. " Time Used: " ..myTimer:getTime(), 0, 5)

    --If debugging is enables then print extra info to the screen
    if (doDebug) then
        for i, cupcake in ipairs(cupcakeIndex) do
            love.graphics.print("Cupcake " ..i.. " position: " ..cupcakeIndex[i].x.. ", " ..cupcakeIndex[i].y.. " !", 0, (love.graphics.getHeight() - 300) + 30 * i)
        end
    end
    -- When 1 tick of our 30 second timer is up then end the game.
    if myTimer.ticksPassed == 1 then
        if love.graphics.getFont() == mainFont then
            love.graphics.setFont(titleFont)
        end
        love.graphics.print("!GAME OVER! Final Score: " ..myPlayer.score , (love.graphics.getWidth() / 2) - (titleFont:getWidth("!GAME OVER! Final Score: " ..myPlayer.score) / 2), 100)
        myTimer:stopCounting()
        game.unload()
    end
end

function game.unload()
    for i = #cupcakeIndex, 1, -1 do
        table.remove(cupcakeIndex, i)
    end
end

return game