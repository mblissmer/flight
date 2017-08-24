
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.HC'

local enemy1 = Class{
  __includes = Entity
}

function enemy1:init(x, y, w, h, scale, speed, animTable, animSpeed, name)
  Entity.init(self, x, y, w, h)
  --Position, size, origin
  self.scale = scale
  self.xOriginOffset = w / 2
  self.yOriginOffset = h / 2  
  
  -- Animation
  self.frames = {}
  for i=1,table.getn(animTable) do
    local qx = animTable[i][1]
    local qy = animTable[i][2]
    table.insert(self.frames, love.graphics.newQuad(qx, qy, w, h, sheetWidth, sheetHeight))
  end
  self.currentFrame = 1
  self.animationSpeed = animSpeed  
  
  self.rect = HC.rectangle(x, y, w * scale, h * scale)
  self.rect.name = name
end

function enemy1:update(dt)
  self.currentFrame = self.currentFrame + self.animationSpeed * dt
  if self.currentFrame >= table.getn(self.frames)+1 then
    self.currentFrame = 1
  end  
  self.rect:moveTo(self.x, self.y)
end

function enemy1:draw()
  love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.x, self.y, 0, self.scale, self.scale, self.xOriginOffset, self.yOriginOffset)
end

return enemy1
