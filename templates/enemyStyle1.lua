
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.HC'

local enemy1 = Class{
  __includes = Entity
}

function enemy1:init(eTable)
  function self.generateYPos()
    self.spawnPointY = math.random(eTable.y[1],eTable.y[2])
  end
  self.generateYPos()
  --Position, size, origin
  Entity.init(self, eTable.x, self.spawnPointY, eTable.w, eTable.h)
  self.spawnPointX = eTable.x
  self.spawnPointY = self.y
  self.scaleX = eTable.scaleX
  self.scaleY = eTable.scaleY
  self.xOriginOffset = eTable.w / 2
  self.yOriginOffset = eTable.h / 2  
  self.active = false
  self.moveUp = true
  
  
  -- Animation
  self.frames = {}
  for i=1,table.getn(eTable.animTable) do
    local qx = eTable.animTable[i][1]
    local qy = eTable.animTable[i][2]
    table.insert(self.frames, love.graphics.newQuad(qx, qy, eTable.w, eTable.h, sheetWidth, sheetHeight))
  end
  self.currentFrame = 1
  self.animationSpeed = eTable.animSpeed  
  
  -- Physics
  local physScale = 0.5
  self.rect = HC.rectangle(
    self.x, 
    self.y, 
    self.w * eTable.scaleX * physScale, 
    self.h * eTable.scaleY * physScale)
  self.rect.name = eTable.name
  
  -- Movement
  self.speedX = eTable.speedX
  self.speedY = eTable.speedY
  self.yLimit = eTable.yLimit
end

function enemy1:activate()
  self.generateYPos()
  self.x = self.spawnPointX
  self.y = self.spawnPointY
  self.active = true
end


function enemy1:update(dt)
  if self.active then
    -- Animation
    self.currentFrame = self.currentFrame + self.animationSpeed * dt
    if self.currentFrame >= table.getn(self.frames)+1 then
      self.currentFrame = 1
    end  
    
    -- Movement
    if self.moveUp then
      self.y = self.y + self.speedY * dt
      if self.y >= self.spawnPointY + self.yLimit then
        self.moveUp = false
      end
    else
      self.y = self.y - self.speedY * dt
      if self.y <= self.spawnPointY - self.yLimit then
        self.moveUp = true
      end
    end
    self.x = self.x - self.speedX * dt
    if self.x < 0 - self.w then
      self.active = false
    end
    
    -- Physics
    self.rect:moveTo(self.x, self.y)
  end
end

function enemy1:draw()
  if self.active then
    love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.x, self.y, 0, self.scaleX, self.scaleY, self.xOriginOffset, self.yOriginOffset) 
--    love.graphics.setColor(255,0,0)
--    self.rect:draw('line')
--    love.graphics.setColor(255,255,255)
  end
end

return enemy1
