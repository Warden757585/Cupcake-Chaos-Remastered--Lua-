local utils = {}
local doResourcePacks


function utils.init()
    print("Utils Starting - " .. os.date("%Y-%m-%d %H:%M:%S"))
    -- Score Checks
    print("Checking score files...")
    if love.filesystem.getInfo("scores.txt") then
        print("Score file found.")
    else
        print("Score file not found. Creating new score file...")
        love.filesystem.write("scores.txt", "")
        print("Score file created.")
    end
    -- Resource Pack Loading:
    if love.filesystem.getInfo("packs.CupcakeChaosFile") then
        print("Resource Packs found")
        local packs = love.filesystem.read("packs.CupcakeChaosFile")
        if packs ~= "" then
            doResourcePacks = true
        end
    else
        print("No resource packs found!")
        doResourcePacks = false
    end
end

function utils.loadResourcePacks()
    local assetTable = {}
    local lineCount = 1
    if doResourcePacks then
        for line in love.filesystem.lines("packs.CupcakeChaosFile") do
            if lineCount == 1 then
                if line:match("Packs:") then
                    print("Pack file valid")
                else
                    --print("Invalid pack file: stopping resource loading!")
                    return
                end
                lineCount = lineCount + 1
            else
                -- This pattern looks for: [Everything] then " - Score: " then [The Number]
                local packName, packDirectory = line:match("%-%s*([^,]+),%s*(.+)")
                
                --print("Sucsessfully loaded: " .. packName .. ", " .. packDirectory)
                local packContents = love.filesystem.getDirectoryItems(packDirectory)
                for i, filename in ipairs(packContents) do
                    --print(filename .. " in " .. packDirectory)
                    local subdirectory = packDirectory .. "/" .. filename
                    if love.filesystem.getInfo(subdirectory).type == "directory" then
                        if filename == "Textures" then
                            local textureContents = love.filesystem.getDirectoryItems(subdirectory)
                            for i, subfilename in ipairs(textureContents) do
                                --print(subfilename .. " in " .. subdirectory)
                                local bottomDirectory = subdirectory .. "/" .. subfilename
                                if subfilename == "Player" then
                                    local playerTextureContents = love.filesystem.getDirectoryItems(bottomDirectory)
                                    for i, playerTexture in ipairs(playerTextureContents) do
                                        print(playerTexture .. " in " .. bottomDirectory)
                                        if playerTexture:lower():match("%.png$") then
                                            --print("A png was found... adding to the asset table")
                                            -- The next line adds the file path, type and pack name of the assets found to the asset table
                                            -- The asset table is later returned for game.lua and cosmetic_menu.lua to read and use
                                            table.insert(assetTable, {bottomDirectory .. "/" .. playerTexture, packName, "playerTexture"})
                                        end
                                    end
                                else
                                    --print("Invalid directory found: continuing...")
                                end
                            end
                        else
                            --print("File in incorrect position / not nessescary: skipping and continuing resource loading...")
                        end
                    end
                end
                lineCount = lineCount + 1
            end
        end
    end
    for i, asset in ipairs(assetTable) do
        -- Unpack the 3 properties from the sub-table
        local path = asset[1]
        local packName = asset[2]
        local assetType = asset[3]
        print("--------------------")
        print(string.format("Item #%d:", i))
        print("  File Path: " .. path)
        print("  From Pack: " .. packName)
        print("  Type:  " .. assetType)
        print("--------------------")
    end
    return assetTable
end

function utils.loadResourceScripts()
    print("--------------------")
    print("Scripts Loading:")
    local scriptTable = {}
    local chunkTable = {}
    local lineCount = 1
    if doResourcePacks then
        for line in love.filesystem.lines("packs.CupcakeChaosFile") do
            if lineCount == 1 then
                if line:match("Packs:") then
                    print("     Pack file valid")
                else
                    print("     Invalid pack file: stopping resource loading!")
                    return
                end
                lineCount = lineCount + 1
            else
                -- This pattern looks for: [Everything] then " - Score: " then [The Number]
                local packName, packDirectory = line:match("%-%s*([^,]+),%s*(.+)")
                --print("Sucsessfully loaded: " .. packName .. ", " .. packDirectory)
                local packContents = love.filesystem.getDirectoryItems(packDirectory)
                for i, filename in ipairs(packContents) do
                    if filename == "Scripts" then
                        local scripts = love.filesystem.getDirectoryItems(packDirectory .. "/" .. "Scripts")
                        for i, script in ipairs(scripts) do
                            if script:lower():match("%.lua$") then
                                print("     " .. packDirectory .. "/" .. filename .. "/" .. script .. " was found!")
                                local path = packDirectory .. "/" .. filename .. "/" .. script
                                local chunk, err = love.filesystem.load(path)

                                if chunk then
                                    table.insert(chunkTable, chunk)
                                    print("     " .. path .. " was successfully loaded!")
                                else
                                    print("     ERROR loading " .. path .. ": " .. tostring(err))
                                end
                            end
                        end
                        for i, chunk in ipairs(chunkTable) do
                            local success, result = pcall(chunk)
                            if success then
                                table.insert(scriptTable, result)
                            else
                                print("     Script Execution Error: " .. tostring(result))
                            end
                        end
                    end
                end
            end
        end
    end
    print("Scripts loaded!")
    print("--------------------")
    return scriptTable
    -- TODO: Next make it so that the api wraps the player in game.lua or main.lua and then runs the user's script
end


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

function utils.getTopScores(n)
    local data = utils.loadScores()
    local topScores = {}
    for i = 1, math.min(n, #data) do
        table.insert(topScores, data[i])
    end
    return topScores
end

return utils