local api = {}


function api.wrapPlayer(playerInstance)
    return {
        -- Wrap player actions
        rotateInputs = function(rotations)
            playerInstance:rotateInputs(rotations)
        end,
        getPos = function()
            return playerInstance.x, playerInstance.y
        end,
        print = print,
        math = math
    }
end

return api

-- TODO:
-- Add similar code to game.lua!
--[[ -- In your main.lua or game.lua
local mods = utils.loadResourceScripts()
local wrappedPlayer = api.wrapPlayer(actualPlayerInstance)

-- Initialize all mods
for _, mod in ipairs(mods) do
    if mod.init then
        mod.init(wrappedPlayer)
    end
end

-- In love.update(dt)
for _, mod in ipairs(mods) do
    if mod.update then
        mod.update(wrappedPlayer, dt)
    end
end ]]