local Cupcake = require("Cupcake")
local Player = require("Player")
local myCupcake
local myPlayer

function love.load()
    -- Set the screen to fullscreen:
    love.window.setFullscreen(true)
    love.graphics.setBackgroundColor( 0, 0.25, 0.6, 0)
    -- Cupcake loading:
    local img_1 = love.graphics.newImage("Assets/Cupcake.png")
    local img_2 = love.graphics.newImage("Assets/Blue Square Guy.png")
    myCupcake = Cupcake.new(350, 250, img_1)
    myPlayer = Player.new(64, 64, img_2)
end

function love.draw()
    myCupcake:draw()
    myPlayer:draw()
end