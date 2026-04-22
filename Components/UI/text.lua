local Text = {}
Text.__index = Text

function Text.new(x, y, text, font)
    local instance = setmetatable({}, Text)
    instance.text = text or "!test!"
    instance.font = font or love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
    instance.width = instance.font:getWidth(instance.text)
    instance.height = instance.font:getHeight()
    instance.x = x - (instance.width / 2)
    instance.y = y - (instance.height / 2)
    return instance
end

function Text:draw()
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x, self.y)
end

function Text:changeText(newText)
    self.text = newText
    self.width = self.font:getWidth(self.text)
    self.height = self.font:getHeight()
    self.x = self.x + (self.width / 2) - (self.width / 2)
    self.y = self.y + (self.height / 2) - (self.height / 2)
end

return Text