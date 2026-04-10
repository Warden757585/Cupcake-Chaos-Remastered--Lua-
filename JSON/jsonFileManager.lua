local jsonFileManager = {}
jsonFileManager.__index = jsonFileManager

local json = require "json"

function jsonFileManager.new(filename)
    local instance = setmetatable({}, jsonFileManager)
    instance.values = {}
    instance.filename = filename or "scores.json"
    return instance
end

function jsonFileManager:load()
    self.values = self:loadFile(self.filename)
end

function jsonFileManager:saveFile(scoreTable)
    local data = json.encode(scoreTable)
    love.filesystem.write(self.filename, data)
end

function jsonFileManager:loadFile(filename)
    local target = filename or self.filename
    if not love.filesystem.getInfo(target) then
        return {} 
    end

    local contents = love.filesystem.read(target)
    
    if not contents or contents == "" then 
        return {} 
    end
    
    return json.decode(contents)
end

function jsonFileManager:addScore(newName, newScore)
    table.insert(self.values, { name = newName, score = newScore })

    table.sort(self.values, function(a, b)
        return a.score > b.score
    end)

    while #self.values > 10 do
        table.remove(self.values)
    end

    self:saveFile(self.values)
end

return jsonFileManager