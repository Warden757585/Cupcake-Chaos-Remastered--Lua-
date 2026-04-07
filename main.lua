local Cupcake = require("Cupcake")
local myCupcake
--wut i dis
function love.load()
    -- Set the screen to fullscreen:
    love.window.setFullscreen(true)
    -- Cupcake loading:
    local img = love.graphics.newImage("Assets/Cupcake.png")
    myCupcake = Cupcake.new(350, 250, img)
end

function love.draw()
    myCupcake:draw()
end