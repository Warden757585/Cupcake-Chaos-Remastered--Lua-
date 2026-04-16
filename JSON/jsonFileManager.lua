local jsonFileManager = {}
jsonFileManager.__index = jsonFileManager


function jsonFileManager.new(filename)
    local instance = setmetatable({}, jsonFileManager)
    instance.values = {}
    instance.filename = filename or "blank.json"
    return instance
end

function jsonFileManager:loadFile()
    local contents = love.filesystem.read(self.filename)
    return contents
end

function jsonFileManager:encodeJSON()
    local jsonString = love.data.encode("string", "application/json", self.values)
    print(jsonString)
    return jsonString
end

return jsonFileManager