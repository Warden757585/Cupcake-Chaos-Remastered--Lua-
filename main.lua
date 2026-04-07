local Cupcake = require("Cupcake")
local myCupcake

function love.load()
    -- Set the screen to fullscreen:
    love.window.setFullscreen(true)
    love.graphics.setBackgroundColor( 0, 0.25, 0.6, 0)
    -- Cupcake loading:
    local img = love.graphics.newImage("Assets/Cupcake.png")
    myCupcake = Cupcake.new(350, 250, img)
end

function love.draw()
    myCupcake:draw()
end