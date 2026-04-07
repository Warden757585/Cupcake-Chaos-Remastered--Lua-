local Cupcake = require("Cupcake")
local Player = require("Player")
local myPlayer
local cupcakeIndex = {}

function love.load()
    -- Set the window initial size and vsync
    love.window.setMode(800, 600, {vsync = 1})
    -- Set the screen to fullscreen
    love.window.setFullscreen(true)
    -- Load all images
    local img_1 = love.graphics.newImage("Assets/Default Textures/cupcwake.png")
    local img_2 = love.graphics.newImage("Assets/Default Textures/porple guy.png")
    -- Add the cupcake(s) to the list of cupcakes index
    table.insert(cupcakeIndex, Cupcake.new(350, 250, img_1))
    myPlayer = Player.new(64, 64, img_2)
end

function love.update(dt)
    myPlayer:playerMovement()
end

function love.keypressed(key)
	if key == "escape" then
		love.window.close()
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
end