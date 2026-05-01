local Text = {}
Text.__index = Text

function Text.new(x, y, text, font, isCentered)
    local instance = setmetatable({}, Text)
    instance.text = text or "!test!"
    instance.font = font or love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
    instance.width = instance.font:getWidth(instance.text)
    instance.height = instance.font:getHeight()
    instance.isCentered = isCentered or false
    if instance.isCentered then
        instance.x = x - (instance.width / 2)
        instance.y = y - (instance.height / 2)
    else
        instance.x = x
        instance.y = y
    end
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
    if self.isCentered then
        self.x = self.x - (self.width / 2)
        self.y = self.y - (self.height / 2)
    else
        self.x = self.x
        self.y = self.y
    end
end

return Text