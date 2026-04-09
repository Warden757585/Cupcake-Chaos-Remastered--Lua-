local Button = {}
Button.__index = Button

function Button.new(x, y, img, text, font)
    local instance = setmetatable({}, Button)
    instance.img = img
    instance.text = text or "!test!"
    instance.font = font or love.graphics.newFont("Assets/Fonts/Legacy Fonts/VT323.ttf", 24, "normal", love.graphics.getDPIScale())
    instance.width = img:getWidth()
    instance.height = img:getHeight()
    instance.x = x - (instance.width / 2)
    instance.y = y - (instance.height / 2)
    return instance
end

function Button:draw()
    love.graphics.draw(self.img, self.x, self.y)
    love.graphics.printf( self.text, self.font, self.x, self.y + ((self.height / 2) - (self.font:getHeight() / 2)), self.width, "center")
end

function Button:isMouseOver()
    local mx, my = love.mouse.getPosition()
    if self.x < mx and mx < self.x + self.width and self.y < my and my < self.y + self.height then
        return true
    else
        return false
    end
end

function Button:isClicked()
    if love.mouse.isDown(1) and self:isMouseOver() then
        return true
    else
        return false
    end
end

return Button