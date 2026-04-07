local Cupcake = require("Cupcake")
local myCupcake

local width, height = love.window.getDesktopDimensions( 1 )

function love.load()
    -- Set the screen to fullscreen:
    love.window.setFullscreen(true)
    -- Cupcake loading:
    local img = love.graphics.newImage("Assets/Cupcake.png")
end




function love.draw()
    love.graphics.draw(cupcake, (width / 2) - (cupcake_width / 2), (height / 2) - (cupcake_height / 2))
    love.graphics.print(cupcake_width, 0, 0)
    love.graphics.print(cupcake_height, 50, 0)
end
-- width = 1920
-- height = 1080
-- cwidth = 64
-- cheight = 64