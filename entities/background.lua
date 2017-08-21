
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'
local HC = require 'libs.HC'

local background = Class{
  __includes = Entity
}

function background:init(x, y)
  self.farWidth = 799
  self.farHeight = 480
  self.nearWidth = 799
  self.nearHeight = 71
  self.far = love.graphics.newQuad(0, 355, self.farWidth, self.farHeight, sheetWidth, sheetHeight)
  self.near = love.graphics.newQuad(0, 0, self.farWidth, self.farHeight, sheetWidth, sheetHeight)
  self.farX = x
  self.farX1 = x + self.farWidth
  self.farY = y
  self.nearX = x
  self.nearX1 = x + self.nearWidth
  self.nearY = screenHeight - self.nearHeight
  self.farMoveSpeed  = 40
  self.nearMoveSpeed = 200
  
  self.colWidth = 50
  self.colCount = math.ceil(self.nearWidth/self.colWidth)
  self.cols = {n=self.colCount}
  self.colBG = {n=self.colCount}
  self.colHeights = {30,30,30,40,60,60,40,40,50,30,20,20,20,40,60,30}
  
  for i = 1, self.colCount do 
    self.cols[i] = HC.rectangle(self.colWidth * (i-1), screenHeight - self.colHeights[i], self.colWidth, self.colHeights[i])
    self.colBG[i] = false
  end
  
  
  Entity.init(self, x, y, self.farWidth, self.farHeight)
end

function background:update(dt)
  self.farX = self.farX - self.farMoveSpeed * dt
  self.farX1 = self.farX1 - self.farMoveSpeed * dt
  
  if self.farX + self.farWidth < 0 then
    self.farX = self.farX1 + self.farWidth
  end
  if self.farX1 + self.farWidth < 0 then
    self.farX1 = self.farX + self.farWidth
  end
  
  self.nearX = self.nearX - self.nearMoveSpeed * dt
  self.nearX1 = self.nearX1 - self.nearMoveSpeed * dt
  if self.nearX + self.nearWidth < 0 then
    self.nearX = self.nearX1 + self.nearWidth
  end
  if self.nearX1 + self.nearWidth < 0 then
    self.nearX1 = self.nearX + self.nearWidth
  end
  
  for i = 1, self.colCount do
    local xpos
    if self.colBG[i] == false then
      xpos = self.nearX + (self.colWidth * (i-1))
    elseif self.colBG[i] == true then
      xpos = self.nearX1 + (self.colWidth * (i-1))
    end
    self.cols[i]:moveTo(xpos,screenHeight - (self.colHeights[i]/2))
    
    local x1,y1,x2,y2 = self.cols[i]:bbox()
--    end
    if x2 < 0 then
      self.colBG[i] = not self.colBG[i]
    end
  end


  
end

function background:draw()
  love.graphics.draw(spritesheet, self.far, self.farX, self.farY)
  love.graphics.draw(spritesheet, self.far, self.farX1, self.farY)
  love.graphics.draw(spritesheet, self.near, self.nearX, self.nearY)
  love.graphics.draw(spritesheet, self.near, self.nearX1, self.nearY)
end

return background
