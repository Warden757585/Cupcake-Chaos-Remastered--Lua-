local Button = require("Components.UI.button")
local Text = require("Components.UI.text")
local Display = require("Components.UI.display")

local cosmetic_menu = {}

-- Font Variable(s):
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
local largeTitleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 96, "normal", love.graphics.getDPIScale())
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false
-- Title and text Variable(s)
local screenWidth = 0
local screenHeight = 0
-- Buttons and menu decorations
local doneButton
local titleText
local bodyDisplay
local bodyDisplayImgs = {}
local bodyDisplayIndex = 1
local leftBodySelecterArrow
local rightBodySelecterArrow

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
    -- Load display image(s)
    -- Display IMG naming: Pack (e.g. Legacy), Type (Player, Hat, Cupcake, etc.), Number/Colour (if there are multiple of the same type in the pack)
    local Legacy_Player_1 = love.graphics.newImage("Assets/Textures/Legacy Textures/Blue Square Guy.png")
    local Default_Player_Blu = love.graphics.newImage("Assets/Textures/Default Textures/Player/blu guy.png")
    local Default_Player_Red = love.graphics.newImage("Assets/Textures/Default Textures/Player/red guy.png")
    local Default_Player_Porple = love.graphics.newImage("Assets/Textures/Default Textures/Player/porple guy.png")
    local Default_Player_Gween = love.graphics.newImage("Assets/Textures/Default Textures/Player/gween guy.png")
    local Default_Player_Wewwow = love.graphics.newImage("Assets/Textures/Default Textures/Player/wewwow guy.png")
    -- Add all the body images to the list
    table.insert(bodyDisplayImgs, Default_Player_Blu)
    table.insert(bodyDisplayImgs, Default_Player_Red)
    table.insert(bodyDisplayImgs, Default_Player_Porple)
    table.insert(bodyDisplayImgs, Default_Player_Gween)
    table.insert(bodyDisplayImgs, Default_Player_Wewwow)

    -- Create the UI elements
    doneButton = Button.new(screenWidth / 2, (screenHeight / 4) * 3, Button_1, "Done", titleFont)
    titleText = Text.new(10, 0, "Cosmetic Menu", largeTitleFont)
    titleText.y = titleText.y + titleText.height
    titleText.x = titleText.x + (titleText.width / 2)
    bodyDisplay = Display.new(screenWidth / 2, screenHeight / 2, Default_Player_Blu, bodyDisplayImgs)
    leftBodySelecterArrow = Button.new((screenWidth / 2) - (bodyDisplay.width / 2) - 128, screenHeight / 2, Left_Arrow_Button, nil, nil, 0.2)
    rightBodySelecterArrow = Button.new((screenWidth / 2) + (bodyDisplay.width / 2) + 128, screenHeight / 2, Right_Arrow_Button, nil, nil, 0.2)
end

function cosmetic_menu.update(dt)
    if leftBodySelecterArrow:isClicked(dt) then
        bodyDisplayIndex = bodyDisplayIndex - 1
        if bodyDisplayIndex < 1 then
            bodyDisplayIndex = #bodyDisplayImgs
        end
    end

    if rightBodySelecterArrow:isClicked(dt) then
        bodyDisplayIndex = bodyDisplayIndex + 1
        if bodyDisplayIndex > #bodyDisplayImgs then
            bodyDisplayIndex = 1
        end
    end

    bodyDisplay:changeImgFromList(bodyDisplayImgs, bodyDisplayIndex)

    if doneButton:isClicked(dt) then
        return "menu"
    end
    return "cosmetic_menu"
end

function cosmetic_menu.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the doneButton
    doneButton:draw()
    -- Draw the title text
    titleText:draw()
    -- Draw the body display
    bodyDisplay:draw()
    -- Draw the body selecter arrows
    leftBodySelecterArrow:draw()
    rightBodySelecterArrow:draw()
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