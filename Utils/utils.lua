local utils = {}

function utils.init()
    print("Utils Starting - " .. os.date("%Y-%m-%d %H:%M:%S"))
    print("Checking score files...")
    if love.filesystem.getInfo("scores.txt") then
        print("Score file found.")
    else
        print("Score file not found. Creating new score file...")
        love.filesystem.write("scores.txt", "")
        print("Score file created.")
    end
end

--[[ function utils.test()
    print("This is a test function in utils")
    local scores = {11, 23, 27, 31, 19}
    table.sort(scores, function(a, b)
    return a > b
    end)
    for k, v in pairs(scores) do
        print("Item: " .. k .. " Value: " .. v)
        love.filesystem.append("scores.txt", "Item: " .. k .. " Value: " .. v .. "\n")
    end
end ]]



function utils.loadScores()
    if love.filesystem.getInfo("scores.txt") then
        --[[ print("Scores loaded!") ]]
        local data = {}
        for line in love.filesystem.lines("scores.txt") do
            -- This pattern looks for: [Everything] then " - Score: " then [The Number]
            local timestamp, score = line:match("(.+) %- Score: (%d+)")
            
            if timestamp and score then
                table.insert(data, {
                    time = timestamp,
                    score = tonumber(score)
                })
            end
        end
        --[[ for i, entry in ipairs(data) do
            print("Entry " .. i .. ": " .. entry.time .. " - Score: " .. entry.score)
        end ]]
        return data
    else
        print("No score file found to load.")
        return {}
    end
end

function utils.addScore(score)
    -- Load existing scores
    local data = utils.loadScores()
    -- Add the new score
    table.insert(data, {
        time = os.date("%Y-%m-%d %H:%M:%S"),
        score = score
    })
    -- Sort the scores in descending order
    table.sort(data, function(a, b)
    return a.score > b.score
    end)
    -- Write the sorted scores back to the file
    love.filesystem.write("scores.txt", "")
    for i, entry in ipairs(data) do
        love.filesystem.append("scores.txt", entry.time .. " - Score: " .. entry.score .. "\n")
    end
end

return utils