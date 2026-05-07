local api = {}

function api.wrapPlayer(playerInstance)
    return {
        rotateInputs = function(rotations)
            playerInstance:rotateInputs(rotations)
        end,
        getTextureInfo = function()
            return playerInstance:getTextureInfo()
        end,
        getPos = function()
            return playerInstance.x, playerInstance.y
        end
    }
end

return api