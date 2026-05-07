local utils = require("Utils.utils")
local game = require("Scenes.game")
local menu = require("Scenes.menu")
local cosmetic_menu = require("Scenes.cosmetic_menu")

local scene = "menu"
local nextScene = scene
local playerBodySprite
local playerTexturePack
local playerTexturePath
local playerHatSprite

local assetTable
local scriptTable


-- Change the compression of images:
love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    playerBodySprite = love.graphics.newImage("Assets/Textures/Default Textures/Player/blu guy.png")
    playerTexturePath = "Assets/Textures/Default Textures/Player/blu guy.png"
    playerTexturePack = "Default"
    playerHatSprite = love.graphics.newImage("Assets/Textures/Default Textures/Player/Accesories/Hats/top hat.png")
    -- Set the screen to fullscreen 
    love.window.setFullscreen(true)
    -- Utility Manager init:
    utils.init()
    assetTable = utils.loadResourcePacks()
    scriptTable = utils.loadResourceScripts()
    if scene == "game" then
        game.load(playerBodySprite, playerHatSprite, scriptTable, playerTexturePack, playerTexturePath)
    end
    if scene == "menu" then
        menu.load()
    end
    if scene == "cosmetic_menu" then
        cosmetic_menu.load(assetTable)
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
            playerBodySprite, playerTexturePack, playerTexturePath = cosmetic_menu.bodyArrowUpdate(dt)
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
            game.load(playerBodySprite, playerHatSprite, scriptTable, playerTexturePack, playerTexturePath)
            scene = nextScene
        end
        if nextScene == "cosmetic_menu" then
            cosmetic_menu.load(assetTable)
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