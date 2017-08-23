
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'
local HC = require 'libs.HC'

local background = Class{
  __includes = Entity
}

function background:init(x, y, w, h, quadX, quadY, speed, colColWidth, colsHeightTable)
  Entity.init(self,x, y, w, h)
  self.img = love.graphics.newQuad(quadX, quadY, w, h, sheetWidth, sheetHeight)
  self.x1 = x + w
  self.moveSpeed  = speed
  self.collisions = false
  if colColWidth ~= nil then
    self.colWidth = colColWidth
    self.collisions = true
    self.colCount = math.ceil(self.w/colColWidth)
    self.cols = {n=self.colCount}
    self.colBG = {n=self.colCount}
    self.colHeights = colsHeightTable
    for i = 1, self.colCount do 
      self.cols[i] = HC.rectangle(colColWidth * (i-1), screenHeight - colsHeightTable[i], colColWidth, colsHeightTable[i])
      self.colBG[i] = false
    end
  end
  
end

function background:update(dt)
  self.x = self.x - self.moveSpeed * dt
  self.x1 = self.x1 - self.moveSpeed * dt
  
  if self.x + self.w < 0 then
    self.x = self.x1 + self.w
  end
  if self.x1 + self.w < 0 then
    self.x1 = self.x + self.w
  end
  if self.collisions then
    for i = 1, self.colCount do
      local xpos
      if self.colBG[i] == false then
        xpos = self.x + (self.colWidth * (i-1))
      elseif self.colBG[i] == true then
        xpos = self.x1 + (self.colWidth * (i-1))
      end
--      self.cols[i]:moveTo(xpos,20)
      self.cols[i]:moveTo(xpos,screenHeight - (self.colHeights[i]/2))
      
      local x1,y1,x2,y2 = self.cols[i]:bbox()
  --    end
      if x2 < 0 then
        self.colBG[i] = not self.colBG[i]
      end
    end
  end
end

function background:draw()
  love.graphics.draw(spritesheet, self.img, self.x, self.y)
  love.graphics.draw(spritesheet, self.img, self.x1, self.y)
end

return background
