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
        end,
        burstVelocity = function(direction, burstStrength, autoDirection)
            direction = {direction[1], direction[2]} or {}
            if autoDirection then
                if playerInstance.x_velocity < 0 then
                    direction[1] = -1
                elseif playerInstance.x_velocity > 0 then
                    direction[1] = 1
                else 
                    direction[1] = 0
                end

                if playerInstance.y_velocity < 0 then
                    direction[2] = -1
                elseif playerInstance.y_velocity > 0 then
                    direction[2] = 1
                else 
                    direction[2] = 0
                end
            end
            playerInstance.x_velocity = playerInstance.x_velocity + (burstStrength * direction[1])
            playerInstance.y_velocity = playerInstance.y_velocity + (burstStrength * direction[2])
        end,
        timer = require("Components.Interactive.timer")
    }
end

return api