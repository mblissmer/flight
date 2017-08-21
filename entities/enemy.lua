
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'
local HC = require 'libs.HC'

local enemy = Class{
  __includes = Entity
}

function enemy:init(x, y)
  --Position, size, origin
  self.x = x
  self.y = y
  self.scale = .5
  self.frame_width = 88
  self.frame_height = 73
  self.xOriginOffset = self.frame_width / 2
  self.yOriginOffset = self.frame_height / 2  
  
  -- Animation
  self.frames = {}
  table.insert(self.frames, love.graphics.newQuad(304, 1967, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(330, 1298, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(330, 1225, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(330, 1298, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  self.currentFrame = 1
  self.animationSpeed = 8  
  
  
  Entity.init(self, x, y, frame_width, frame_height)
  
  self.rect = HC.rectangle(self.x,self.y,self.frame_width * self.scale ,self.frame_height * self.scale)
end

function enemy:update(dt)
  self.currentFrame = self.currentFrame + self.animationSpeed * dt
  if self.currentFrame >= table.getn(self.frames)+1 then
    self.currentFrame = 1
  end  
  self.rect:moveTo(self.x, self.y)
end

function enemy:draw()
  love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.x, self.y, 0, self.scale, self.scale, self.xOriginOffset, self.yOriginOffset)
end

return enemy
