
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.hc'

local object1 = Class{
  __includes = Entity
}

function object1:init(eTable)
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
  
  
  local n = math.random(0,1)
  self.moveUp = true
  if n < 0.5 then
    self.moveUp = false
  end
  
  
  -- Animation
  self.frames = {}
  for i=1,table.getn(eTable.animTable) do
    local qx = eTable.animTable[i][1]
    local qy = eTable.animTable[i][2]
    table.insert(self.frames, love.graphics.newQuad(qx, qy, eTable.w, eTable.h, sheetWidth, sheetHeight))
  end
  self.currentFrame = 1
  self.animationSpeed = eTable.animSpeed  
  self.rot = 0
  self.rotates = false
  if eTable.rotSpeed then
    self.rotates = true
    self.rotSpeed = eTable.rotSpeed
  end
  
  -- Physics
  local physScale = eTable.physScale
--  self.phys = HC.rectangle(
--    self.x, 
--    self.y, 
--    self.w * eTable.scaleX * eTable.physScale, 
--    self.h * eTable.scaleY * eTable.physScale)
  self.phys = HC.circle(
    self.x,
    self.y, 
    eTable.w * eTable.physScale)
  self.phys.name = eTable.name
  self.phys.kill = function()
    self:deactivate()
  end
  
  -- Movement
  self.speedX = eTable.speedX
  self.speedY = eTable.speedY
  self.yLimit = eTable.yLimit
end

function object1:activate()
  self.generateYPos()
  self.x = self.spawnPointX
  self.y = self.spawnPointY
  self.active = true
end

function object1:deactivate()
  self.active = false
  self.x = self.spawnPointX
  self.y = self.spawnPointY
  self.phys:moveTo(self.x, self.y)
end


function object1:update(dt)
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
    
    -- Rotation
    if self.rotates then
      self.rot = self.rot + self.rotSpeed * dt
      if self.rot >= 6.28 then
        self.rot = 0
      end
    end
    
    -- Physics
    self.phys:moveTo(self.x, self.y)
  end
end

function object1:draw()
  if self.active then
    love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.x, self.y, self.rot, self.scaleX, self.scaleY, self.xOriginOffset, self.yOriginOffset) 
    love.graphics.setColor(255,0,0)
    self.phys:draw('line')
    love.graphics.setColor(255,255,255)
  end
end



return object1
