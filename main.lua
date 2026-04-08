local Cupcake = require("Cupcake")
local Player = require("Player")
local myPlayer
local cupcakeIndex = {}
local seed = 5
-- Debug variables:
local doDebug = false
local doKeyDebug = false

function love.load()
    -- Set the screen to fullscreen
    love.window.setFullscreen(true)
    -- Load all images
    local img_1 = love.graphics.newImage("Assets/Textures/Default Textures/cupcwake.png")
    local img_2 = love.graphics.newImage("Assets/Textures/Default Textures/porple guy.png")
    -- Add the cupcake(s) to the list of cupcakes index
    table.insert(cupcakeIndex, Cupcake.new(350, 250, img_1, seed)) -- Cupcake 1
    table.insert(cupcakeIndex, Cupcake.new(650, 550, img_1, seed)) -- Cupcake 2
    myPlayer = Player.new(64, 64, img_2, seed)

    for i, cupcake in ipairs(cupcakeIndex) do
        cupcakeIndex[i].seed = cupcakeIndex[i].seed + i * 100200300
    end
end

function love.update(dt)
    myPlayer:playerMovement()
    myPlayer:checkCupcakes(cupcakeIndex)
end

function love.keypressed(key)
	if key == "escape" then
		love.window.close()
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

function love.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the cupcake and player
    for i, cupcake in ipairs(cupcakeIndex) do
        cupcake:draw()
    end
    myPlayer:draw()
    love.graphics.print("Score: " ..myPlayer.score.. " Speed: " ..myPlayer.speed , 0, love.graphics.getHeight() - 20)

    --If debugging is enables then print extra info to the screen
    if (doDebug) then
        for i, cupcake in ipairs(cupcakeIndex) do
            love.graphics.print("Cupcake " ..i.. " position: " ..cupcakeIndex[i].x.. ", " ..cupcakeIndex[1].y.. " !", 0, 10 * i)
        end
    end
end