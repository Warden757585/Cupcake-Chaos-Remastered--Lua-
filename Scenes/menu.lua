local Button = require("Components.UI.button")
local Text = require("Components.UI.text")

local menu = {}

-- Font Variable(s):
local titleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 54, "normal", love.graphics.getDPIScale())
local largeTitleFont = love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 96, "normal", love.graphics.getDPIScale())
-- Debug variable(s):
local doDebug = false
local doKeyDebug = false
-- Title and text Variable(s)
local screenWidth = 0
local screenHeight = 0
local title = "Welcome to Cupcake Chaos"
local textWidth = largeTitleFont:getWidth(title)
local textHeight = largeTitleFont:getHeight()
-- Buttons and menu decorations
local startButton
local cosmeticMenuButton
local titleText
-- Audio Variable(s):
local buttonPressSound = love.audio.newSource("Assets/Audio/Default Audio/Menu Blip 1.wav", "static")

function menu.load()
    -- Set the font to the titleFont
    love.graphics.setFont(largeTitleFont)
    -- Get the screen widht and height
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    -- Load button image(s)
    local Button_1 = love.graphics.newImage("Assets/Textures/Menu Textures/Buttons/320x160 px Button.png")
    -- Create the start button
    startButton = Button.new(screenWidth / 2, screenHeight / 2, Button_1, "Start", titleFont)
    -- Create the cosmetic menu button
    cosmeticMenuButton = Button.new(screenWidth / 2, (screenHeight / 3) * 2, Button_1, "Cosmetic Menu", titleFont)
    -- Create the title text
    titleText = Text.new(screenWidth / 2, screenHeight / 4, title, largeTitleFont)
end

function menu.update(dt)
    if startButton:isClicked(dt, buttonPressSound) then
        startButton.text = "Starting..."
        return "game"
    end
    if cosmeticMenuButton:isClicked(dt, buttonPressSound) then
        cosmeticMenuButton.text = "Loading..."
        return "cosmetic_menu"
    end
    return "menu"
end

function menu.draw()
    -- Clear the screen for drawing
    love.graphics.clear()
    -- Draw the menu components
    startButton:draw()
    cosmeticMenuButton:draw()
    titleText:draw()
    -- Debug Info drawing
    if doDebug then
        love.graphics.print("Mouse: " ..love.mouse.getX().. ", " ..love.mouse.getY().. " Button Top Left: " ..startButton.x.. ", " ..startButton.y , 0, 0)
    end
end

function menu.keypressed(key)
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

return menu