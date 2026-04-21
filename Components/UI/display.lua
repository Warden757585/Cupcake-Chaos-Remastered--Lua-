local Display = {}
Display.__index = Display

function Display.new(x, y, img, imgs)
    local instance = setmetatable({}, Display)
    instance.img = img
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()
    instance.x = x - (instance.width / 2)
    instance.y = y - (instance.height / 2)
    instance.imgs = imgs or {}
    return instance
end

function Display:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

function Display:changeImg(newImg)
    self.img = newImg
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
end

function Display:changeImgFromList(imgList, index)
    if self.imgs ~= {} then
        self.img = imgList[index]
    end
end

return Display