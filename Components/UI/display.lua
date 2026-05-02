local Display = {}
Display.__index = Display

function Display.new(x, y, img, imgs, scaling, rotation)
    local instance = setmetatable({}, Display)
    instance.img = img
    instance.imgs = imgs or {}
    instance.hatImg = nil
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

function Display:changeImgFromList(index, imgList)
    self.imagePackType = self.imgs[index][2]
    if self.imgs ~= {} then
        self.img = self.imgs[index][1]
    else
        self.img = imgList[index][1]
    end
end

function Display:changeHatFromList(index, imgList)
    if imgList and #imgList > 0 and index > 0 and index <= #imgList then
        self.hatImg = imgList[index]
    else
        self.hatImg = nil
    end
end


function Display:getImagePackType()
    return self.imagePackType
end

function Display:renderHatAccesory()
    if self.hatImg ~= nil then
        local hatScale = self.scaling * 2
        local hatWidth = self.hatImg:getWidth() * hatScale
        local hatHeight = self.hatImg:getHeight() * hatScale
        local hatX = self.x + (self.width - hatWidth) / 2
        local hatY = self.y - hatHeight / 2
        love.graphics.draw(self.hatImg, hatX, hatY, self.rotation, hatScale, hatScale)
    end
end

return Display