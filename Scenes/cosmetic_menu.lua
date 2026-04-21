local Button = require("Components.UI.button")

local cosmetic_menu = {}

-- Font Variable(s):
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false
-- Title and text Variable(s)
local screenWidth = 0
local screenHeight = 0
-- Buttons and menu decorations
local doneButton

function cosmetic_menu.load()
    -- Set the font to the titleFont
    love.graphics.setFont(titleFont)
    -- Get the screen widht and height
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    -- Load button image(s)
    local Button_1 = love.graphics.newImage("Assets/Textures/Menu Textures/Buttons/320x160 px Button.png")
    local Left_Arrow_Button = love.graphics.newImage("Assets/Textures/Menu Textures/Buttons/64x64 Left Arrow Button.png")
    local Right_Arrow_Button = love.graphics.newImage("Assets/Textures/Menu Textures/Buttons/64x64 Right Arrow Button.png")

    doneButton = Button.new(screenWidth / 2, (screenHeight / 4) * 3, Button_1, "Done", titleFont)
end

function cosmetic_menu.update(dt)
    if doneButton:isClicked() then
        return "menu"
    end
    return "cosmetic_menu"
end

function cosmetic_menu.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the doneButton
    doneButton:draw()
end

function cosmetic_menu.keypressed(key)
    if key == "escape" then
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

return cosmetic_menu