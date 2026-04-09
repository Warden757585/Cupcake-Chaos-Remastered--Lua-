local Timer = {}
Timer.__index = Timer

function Timer.new(duration)
    local instance = setmetatable({}, Timer)
    instance.duration = duration
    instance.time = 0
    instance.ticksPassed = 0 --The ticks represent how many times the timer has reached its duration. e.g. if a 30s timer has ran for 60s the ticks would be 2
    instance.isCounting = false
    return instance
end

function Timer:updateTime(dt)
    if self.isCounting then
        self.time = self.time + dt
        if(self.duration <= self.time) then
            self.ticksPassed = self.ticksPassed + 1
            self.time = 0
        end
    end
end

function Timer:resetTicks()
    self.ticksPassed = 0
end

function Timer:getTime()
    return self.time
end

function Timer:getTicksPassed()
    return self.ticksPassed
end

function Timer:startCounting()
    self.isCounting = true
end

function Timer:stopCounting()
    self.isCounting = false
end

return Timer