local Display = {}
Display.__index = Display

function Display.new(x, y, img, imgs, scaling, rotation)
    local instance = setmetatable({}, Display)
    instance.img = img
    instance.imgs = imgs or {}
    instance.scaling = scaling or 1
    instance.rotation = rotation or 0
    instance.width = instance.img:getWidth() * scaling
    instance.height = instance.img:getHeight() * scaling
    instance.x = x - instance.width / 2
    instance.y = y - instance.height / 2
    instance.imagePackType = "default"
    return instance
end

function Display:draw()
    love.graphics.draw(self.img, self.x, self.y, self.rotation, self.scaling, self.scaling)
end

function Display:changeImg(newImg, imagePackType)
    self.img = newImg
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.imagePackType = imagePackType or "default"
end

function Display:changeImgFromList(index, imagePacktype, imgList)
    self.imagePackType = imagePacktype or "default"
    if self.imgs ~= {} then
        self.img = self.imgs[index]
    else
        self.img = imgList[index]
    end
end

function Display:getImagePackType()
    return self.imagePackType
end

return Display