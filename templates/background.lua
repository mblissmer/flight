
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.hc'

local background = Class{
  __includes = Entity
}

function background:init(bgTable)
  Entity.init(self,bgTable.x, bgTable.y, bgTable.w, bgTable.h)
  self.img = love.graphics.newQuad(
    bgTable.quadX, bgTable.quadY, 
    bgTable.w, bgTable.h, 
    sheetWidth, sheetHeight)
  self.moveSpeed  = bgTable.speed
  self.scale = screenWidth / 1920 * bgTable.scale
  self.y = screenHeight - bgTable.h * self.scale
  self.x1 = bgTable.x + bgTable.w * self.scale
  -- Collisions
  self.collisions = false
  if bgTable.colColWidth then
    self.colWidth = bgTable.colColWidth
    self.collisions = true
    self.colCount = math.ceil(self.w/bgTable.colColWidth)
    self.cols = {n=self.colCount}
    self.colHeights = bgTable.colsHeightTable
    for i = 1, self.colCount do 
      self.cols[i] = HC.rectangle(bgTable.colColWidth * (i-1), 
        screenHeight - bgTable.colsHeightTable[i], 
        bgTable.colColWidth, 
        bgTable.colsHeightTable[i])
      self.cols[i].name = bgTable.colName
      self.cols[i].loopedPosition = false
      
    end
  end
  
end

function background:update(dt)
  self.x = self.x - self.moveSpeed * dt
  self.x1 = self.x1 - self.moveSpeed * dt
  
  if self.x + self.w * self.scale < 0 then
    self.x = self.x1 + self.w * self.scale
  end
  if self.x1 + self.w * self.scale < 0 then
    self.x1 = self.x + self.w * self.scale
  end
  
  -- Collisions
  if self.collisions then
    for i = 1, self.colCount do
      local xpos
      if self.cols[i].loopedPosition == false then
        xpos = self.x + (self.colWidth * (i-1))
      elseif self.cols[i].loopedPosition == true then
        xpos = self.x1 + (self.colWidth * (i-1))
      end
--      self.cols[i]:moveTo(xpos,20)
      self.cols[i]:moveTo(xpos,screenHeight - (self.colHeights[i]/2))
      
      local x1,y1,x2,y2 = self.cols[i]:bbox()
  --    end
      if x2 < 0 then
        self.cols[i].loopedPosition = not self.cols[i].loopedPosition
      end
    end
  end
end

function background:draw()
  love.graphics.draw(spritesheet, self.img, self.x, self.y, 0, self.scale, self.scale)
  love.graphics.draw(spritesheet, self.img, self.x1, self.y, 0, self.scale, self.scale)
--  if self.collisions then
--    love.graphics.setColor(255,0,0)
--    for i = 1, self.colCount do
--      self.cols[i]:draw('line')
--    end
--    love.graphics.setColor(255,255,255)
--  end
end

return background
