local Cupcake = require("Cupcake")
local Player = require("Player")
local Timer = require("Components.Interactive.timer")
local TileAtlas = require("Tilemap.tile_atlas")
local Utils = require("Utils.utils")

local game = {}

-- Object Variable(s):
local myPlayer
local myTimer
local cupcakeIndex = {}
local playerHatSprite
-- Tilemap Variable(s):
local tileAtlas
-- Sprite Batches:
local cupcakeBatch
local playerBatch
local hatBatch
-- Game Variable(s):
local seed
local hasScored = false
local isGameOver = false
-- Font Variable(s):
local mainFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 36, "normal", love.graphics.getDPIScale())
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
-- Audio variable(s):
local scoreSound = love.audio.newSource("Assets/Audio/Legacy Audio/Score.wav", "static")
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false


function game.load(playerBodySprite, hatSprite)
    seed = os.time() + love.timer.getTime() * 1000
    love.math.setRandomSeed(os.time())
    -- Set the current font to mainFont
    love.graphics.setFont(mainFont)
    -- Load all images
    local img_1 = love.graphics.newImage("Assets/Textures/Default Textures/Cupcake/cupcwake.png")
    local img_2
    if type(playerBodySprite) == "string" then
        img_2 = love.graphics.newImage(playerBodySprite)
    else
        img_2 = playerBodySprite
    end
    -- Store the hat sprite
    if type(hatSprite) == "string" and hatSprite ~= "no hat" then
        playerHatSprite = love.graphics.newImage(hatSprite)
    elseif hatSprite == "no hat" then
        playerHatSprite = nil
    else
        playerHatSprite = hatSprite
    end
    table.insert(cupcakeIndex, Cupcake.new(350, 250, img_1, seed, scoreSound)) -- Cupcake 1
    table.insert(cupcakeIndex, Cupcake.new(650, 550, img_1, seed, scoreSound)) -- Cupcake 2
    for i in ipairs(cupcakeIndex) do
        cupcakeIndex[i].x = love.math.random(0, love.graphics.getWidth() - cupcakeIndex[i].width)
        cupcakeIndex[i].y = love.math.random(0, love.graphics.getHeight() - cupcakeIndex[i].height)
    end
    -- Reset the isGameOver and hasScored variables to false for the new game
    isGameOver = false
    hasScored = false
    -- Set the timer to have our desired duration. Then we st it running
    if doDebug then
        myTimer = Timer.new(5)
    else
        myTimer = Timer.new(30)
    end
    myTimer:startCounting()
    -- Declare our player
    myPlayer = Player.new(64, 64, img_2, seed)
    -- Assign each cupcake its own individual seed so that they do not re-position to the same coordinates
    -- Changing the game's seed still affects each cupcake
    for i in ipairs(cupcakeIndex) do
        cupcakeIndex[i].seed = cupcakeIndex[i].seed + i * 100200300
    end
    -- Create separate sprite batches for each image type
    cupcakeBatch = love.graphics.newSpriteBatch(img_1, 100, "dynamic")
    playerBatch = love.graphics.newSpriteBatch(img_2, 100, "dynamic")
    if playerHatSprite ~= nil then
        hatBatch = love.graphics.newSpriteBatch(playerHatSprite, 100, "dynamic")
    end
    -- Tile map stuff:
    tileAtlas = TileAtlas.new(love.graphics.newImage("Assets/Textures/Tilemaps/Default Tilemap/kitchen_v1.png"), 4) -- Assets/Textures/Tilemaps/test/kitchen_v1.png has 18x18 (324) tiles 
    tileAtlas:loadFromTileset()
    -- Utils Testing:
    Utils.init()
    end

function game.update(dt)
    myPlayer:playerMovement()
    myPlayer:checkCupcakes(cupcakeIndex)
    myTimer:updateTime(dt)
    -- When 1 tick of our 30 second timer is up then end the game.
    if myTimer.ticksPassed == 1 then
        isGameOver = true
    end
    -- Game Over procedure:
    if(isGameOver) then
        -- If the player has not scored yet then add their score to the json file
        if(hasScored == false) then
            Utils.addScore(myPlayer.score)
            hasScored = true -- Then change hasScore to true to represent to the game that the player has score and not to score multiple times
        end
        myTimer:stopCounting()
        game.unload()
    end
end

function game.keypressed(key)
	if key == "escape" then
		isGameOver = true
        if isGameOver then
            return "menu"
        end
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


local floorLayerMatrix = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                         {0, 0, 0, 0, 0, 0, 0, 283, 284, 285},
                         {0, 0, 0, 0, 0, 0, 0, 301, 302, 303},
                         {0, 0, 0, 0, 0, 0, 0, 319, 320, 321}}
local wallLayerMatrix = {{0, 0, 0, 0, 0, 0, 0, 322, 323, 324},
                         {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                         {0, 0, 0, 0, 0, 0, 0, 0, 291, 0}}

function game.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    cupcakeBatch:clear()
    playerBatch:clear()
    if playerHatSprite ~= nil then
        hatBatch:clear()
    end
    -- Tilemap Drawing:
    tileAtlas:drawLayer(floorLayerMatrix)
    tileAtlas:drawLayer(wallLayerMatrix)
    -- Draw the cupcake and player
    for i, cupcake in ipairs(cupcakeIndex) do
        cupcake:draw(cupcakeBatch)
    end
    myPlayer:draw(playerBatch)
    myPlayer:renderHatAccesory(playerHatSprite, hatBatch)
    if love.graphics.getFont() == titleFont then
        love.graphics.setFont(mainFont)
    end
    love.graphics.print("Score: " ..myPlayer.score.. " Speed: " ..myPlayer.speed.. " Time Used: " ..myTimer:getTime(), 0, 5)
    love.graphics.draw(cupcakeBatch)
    love.graphics.draw(playerBatch)
    if playerHatSprite ~= nil then
        love.graphics.draw(hatBatch)
    end

    --If debugging is enables then print extra info to the screen
    if (doDebug) then
        for i, cupcake in ipairs(cupcakeIndex) do
            love.graphics.print("Cupcake " ..i.. " position: " ..cupcakeIndex[i].x.. ", " ..cupcakeIndex[i].y.. " !", 0, (love.graphics.getHeight() - 300) + 30 * i)
        end
    end
    if isGameOver then
        if love.graphics.getFont() == mainFont then
            love.graphics.setFont(titleFont)
        end
        love.graphics.print("!GAME OVER! Final Score: " ..myPlayer.score , (love.graphics.getWidth() / 2) - (titleFont:getWidth("!GAME OVER! Final Score: " ..myPlayer.score) / 2), 100)
    end
end

function game.unload()
    for i = #cupcakeIndex, 1, -1 do
        table.remove(cupcakeIndex, i)
    end
    hasScored = true
end

return game