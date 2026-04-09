local game = require("Scenes.game")
local menu = require("Scenes.menu")

local scene = "menu"
local nextScene = scene

function love.load()
    -- Set the screen to fullscreen 
    love.window.setFullscreen(true)
    if scene == "game" then
        game.load()
    end
    if scene == "menu" then
        menu.load()
    end
end

function love.update(dt)
    if scene == "game" then
        game.update(dt)
    end
    if scene == "menu" then
        nextScene = menu.update(dt)
    end

    --Check if the current scene is equal to the next scene
    if scene ~= nextScene then
        if nextScene == "menu" then
            menu.load()
            game.unload()
            scene = nextScene
        end
        if nextScene == "game" then
            game.load()
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
end

function love.keypressed(key)
    if scene == "game" then
        game.keypressed(key)
        if game.keypressed(key) == "menu" then
            nextScene = "menu"
        end
    end
    if scene == "menu" then
        menu.keypressed(key)
    end
end