local game = require("Scenes.game")
local menu = require("Scenes.menu")
local cosmetic_menu = require("Scenes.cosmetic_menu")

local scene = "menu"
local nextScene = scene
local playerBodySprite = "Assets/Textures/Default Textures/Player/blu guy.png"
local playerHatSprite = "Assets/Textures/Default Textures/Player/Accesories/Hats/top hat.png"

function love.load()
    -- Set the screen to fullscreen 
    love.window.setFullscreen(true)
    if scene == "game" then
        game.load(playerBodySprite, playerHatSprite)
    end
    if scene == "menu" then
        menu.load()
    end
    if scene == "cosmetic_menu" then
        cosmetic_menu.load()
    end
end

function love.update(dt)
    -- Only call scene update if we're not already transitioning
    if scene == nextScene then
        if scene == "game" then
            game.update(dt)
        end
        if scene == "menu" then
            nextScene = menu.update(dt)
        end
        if scene == "cosmetic_menu" then
            nextScene = cosmetic_menu.update(dt)
            playerBodySprite = cosmetic_menu.bodyArrowUpdate(dt)
            playerHatSprite = cosmetic_menu.hatArrowUpdate(dt)
        end
    end

    --Check if the current scene is equal to the next scene
    if scene ~= nextScene then
        if nextScene == "menu" then
            menu.load()
            game.unload()
            scene = nextScene
        end
        if nextScene == "game" then
            game.load(playerBodySprite, playerHatSprite)
            scene = nextScene
        end
        if nextScene == "cosmetic_menu" then
            cosmetic_menu.load()
            scene = nextScene
        end
    end
end

function love.draw()
    if scene == "game" then
        game.draw()
    end
    if scene == "menu" then
        menu.draw()
    end
    if scene == "cosmetic_menu" then
        cosmetic_menu.draw()
    end
end

function love.keypressed(key)
    if scene == "game" then
        local result = game.keypressed(key)
        if result == "menu" then
            nextScene = "menu"
        end
    end
    if scene == "menu" then
        local result = menu.keypressed(key)
    end
    if scene == "cosmetic_menu" then
        local result = cosmetic_menu.keypressed(key)
        if result == "menu" then
            nextScene = "menu"
        end
    end
end