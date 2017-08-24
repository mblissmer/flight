local background = require 'templates.background'

local Backgrounds = {
  active = true,
  backgroundList = {}
}

function Backgrounds:enter(bgtable)
  self.backgroundList = {}
  for i, bg in ipairs(bgtable) do
    local back = background(bg.x, bg.y, bg.w, bg.h, bg.quadX, bg.quadY, bg.speed, bg.colColWidth, bg.colsHeightTable)
    table.insert(self.backgroundList, back)
  end
  
end

function Backgrounds:draw()
  for i, b in ipairs(self.backgroundList) do
    b:draw(i)
  end
end

function Backgrounds:update(dt)
  for i, b in ipairs(self.backgroundList) do
    b:update(dt, i)
  end
end

return Backgrounds