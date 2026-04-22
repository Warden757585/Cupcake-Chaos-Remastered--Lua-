local Button = require("Components.UI.button")
local Text = require("Components.UI.text")
local Display = require("Components.UI.display")

local cosmetic_menu = {}

-- Font Variable(s):
local defaultFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
local largeDefaultFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 36, "normal", love.graphics.getDPIScale())
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
local largeTitleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 96, "normal", love.graphics.getDPIScale())
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false
-- Screen size variables:
local screenWidth = 0
local screenHeight = 0
-- Buttons and menu decorations
local doneButton
local titleText
local packText
-- Body selecter stuff
local bodyDisplay
local bodyDisplayImgs = {}
local bodyDisplayIndex = 1
local leftBodySelecterArrow
local rightBodySelecterArrow
-- Hat selecter stuff
local hatDisplayImgs = {}
local hatDisplayIndex = 1
local leftHatSelecterArrow
local rightHatSelecterArrow
-- Audio Variable(s):
local buttonPressSound = love.audio.newSource("Assets/Audio/Default Audio/Menu Blip 1.wav", "static")

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
    local Legacy_Player = love.graphics.newImage("Assets/Textures/Legacy Textures/Blue Square Guy.png")
    local Default_Player_Blu = love.graphics.newImage("Assets/Textures/Default Textures/Player/blu guy.png")
    local Default_Player_Red = love.graphics.newImage("Assets/Textures/Default Textures/Player/red guy.png")
    local Default_Player_Porple = love.graphics.newImage("Assets/Textures/Default Textures/Player/porple guy.png")
    local Default_Player_Gween = love.graphics.newImage("Assets/Textures/Default Textures/Player/gween guy.png")
    local Default_Player_Wewwow = love.graphics.newImage("Assets/Textures/Default Textures/Player/wewwow guy.png")
    local Default_Hat_TopHat = love.graphics.newImage("Assets/Textures/Default Textures/Player/Accesories/Hats/top hat.png")
    -- Clear the image tables if they have data
    bodyDisplayImgs = {}
    hatDisplayImgs = {}
    -- Add all the body images to the list
    table.insert(bodyDisplayImgs, Default_Player_Blu)
    table.insert(bodyDisplayImgs, Default_Player_Red)
    table.insert(bodyDisplayImgs, Default_Player_Porple)
    table.insert(bodyDisplayImgs, Default_Player_Gween)
    table.insert(bodyDisplayImgs, Default_Player_Wewwow)
    table.insert(bodyDisplayImgs, Legacy_Player)
    -- Change the image filter of the player textures to allow for resizing without blurring
    for i in ipairs(bodyDisplayImgs) do
        bodyDisplayImgs[i]:setFilter("nearest", "nearest")
    end
    -- Add hats to their respective list and set their scaling filter
    table.insert(hatDisplayImgs, Default_Hat_TopHat)
    for i in ipairs(hatDisplayImgs) do
        hatDisplayImgs[i]:setFilter("nearest", "nearest")
    end
    -- Create the UI elements (preserve button state if they exist, otherwise create new)
    if not doneButton then
        doneButton = Button.new(screenWidth / 2, (screenHeight / 6) * 5, Button_1, "Done", titleFont)
    end
    titleText = Text.new(10, 0, "Cosmetic Menu", largeTitleFont)
    titleText.y = titleText.y + titleText.height
    titleText.x = titleText.x + (titleText.width / 2)
    packText = Text.new(screenWidth / 2, (screenHeight / 8) * 5, "Default Pack", titleFont)
    bodyDisplay = Display.new(screenWidth / 2, screenHeight / 2, Default_Player_Blu, bodyDisplayImgs, 2)
    if not leftBodySelecterArrow then
        leftBodySelecterArrow = Button.new((screenWidth / 2) - (bodyDisplay.width / 2) - 128, screenHeight / 2, Left_Arrow_Button, nil, nil, 0.6)
        rightBodySelecterArrow = Button.new((screenWidth / 2) + (bodyDisplay.width / 2) + 128, screenHeight / 2, Right_Arrow_Button, nil, nil, 0.6)
        leftHatSelecterArrow = Button.new((screenWidth / 2) - (bodyDisplay.width / 2) - 128, screenHeight / 2 - Default_Hat_TopHat:getHeight() * 2, Left_Arrow_Button, nil, nil, 0.6)
        rightHatSelecterArrow = Button.new((screenWidth / 2) + (bodyDisplay.width / 2) + 128, screenHeight / 2 - Default_Hat_TopHat:getHeight() * 2, Right_Arrow_Button, nil, nil, 0.6)
    end
    -- Restore the hat selection
    if hatDisplayIndex > #hatDisplayImgs then
        bodyDisplay.hatImg = nil
    else
        bodyDisplay:changeHatFromList(hatDisplayIndex, hatDisplayImgs)
    end
end

function cosmetic_menu.update(dt)
    cosmetic_menu.bodyArrowUpdate(dt)
    cosmetic_menu.hatArrowUpdate(dt)
    if doneButton:isClicked(dt, buttonPressSound) then
        return "menu"
    end
    return "cosmetic_menu"
end

function cosmetic_menu.bodyArrowUpdate(dt)
    
    if leftBodySelecterArrow:isClicked(dt, buttonPressSound) then
        bodyDisplayIndex = bodyDisplayIndex - 1
        if bodyDisplayIndex < 1 then
            bodyDisplayIndex = #bodyDisplayImgs
        end
    end

    if rightBodySelecterArrow:isClicked(dt, buttonPressSound) then
        bodyDisplayIndex = bodyDisplayIndex + 1
        if bodyDisplayIndex > #bodyDisplayImgs then
            bodyDisplayIndex = 1
        end
    end

    if bodyDisplayIndex ==  6 then
        bodyDisplay:changeImgFromList(bodyDisplayIndex, "legacy")
        packText:changeText("Legacy Pack")
    else
        bodyDisplay:changeImgFromList(bodyDisplayIndex, "default")
        packText:changeText("Default Pack")
    end
    return bodyDisplayImgs[bodyDisplayIndex]
end

function cosmetic_menu.hatArrowUpdate(dt)
    
    if leftHatSelecterArrow:isClicked(dt, buttonPressSound) then
        hatDisplayIndex = hatDisplayIndex - 1
        if hatDisplayIndex < 1 then
            hatDisplayIndex = #hatDisplayImgs + 1  -- +1 for "no hat" option
        end
    end

    if rightHatSelecterArrow:isClicked(dt, buttonPressSound) then
        hatDisplayIndex = hatDisplayIndex + 1
        if hatDisplayIndex > #hatDisplayImgs + 1 then  -- +1 for "no hat" option
            hatDisplayIndex = 1
        end
    end

    if hatDisplayIndex > #hatDisplayImgs then
        bodyDisplay.hatImg = nil  -- Remove hat
    else
        bodyDisplay:changeHatFromList(hatDisplayIndex, hatDisplayImgs)
    end
    return hatDisplayImgs[hatDisplayIndex] or nil
end

function cosmetic_menu.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the doneButton
    doneButton:draw()
    -- Draw the title text
    titleText:draw()
    -- Other text component drawing
    packText:draw()
    -- Draw the body display
    bodyDisplay:draw()
    bodyDisplay:renderHatAccesory()
    -- Draw the body selecter arrows
    leftBodySelecterArrow:draw()
    rightBodySelecterArrow:draw()
    -- Draw the hat selecter arrows
    leftHatSelecterArrow:draw()
    rightHatSelecterArrow:draw()
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