
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.hc'

local player = Class{
  __includes = Entity
}



function player:init(pTable)
    -- Init Class
  Entity.init(self, pTable.x, pTable.y, pTable.w, pTable.h)
  -- Properties
  self.inControl = true
  self.isAlive = true
  self.xOriginOffset = pTable.w / 2
  self.yOriginOffset = pTable.h / 2
  self.rot = 0
  self.pos = {self.x,self.y}
  self.maxRot = pTable.maxRot
  self.rotSpeed = pTable.rotSpeed
  self.rotTolerance = pTable.rotTolerance
  self.scaleX = pTable.scaleX
  self.scaleY = pTable.scaleY
  self.moveSpeed = pTable.moveSpeed
  
  -- Animation Info
  self.frames = {}
  for i=1,table.getn(pTable.animTable) do
    local qx = pTable.animTable[i][1]
    local qy = pTable.animTable[i][2]
    table.insert(self.frames, love.graphics.newQuad(qx, qy, pTable.w, pTable.h, sheetWidth, sheetHeight))
  end
  self.currentFrame = 1
  self.animationSpeed = pTable.animSpeed
  
--  self.swirlFrames = {}
--    table.insert(self.swirlFrames, love.graphics.newQuad(170, 1996, 39, 37, sheetWidth, sheetHeight))
--  table.insert(self.swirlFrames, love.graphics.newQuad(369, 1444, 39, 37, sheetWidth, sheetHeight))
--  table.insert(self.swirlFrames, love.graphics.newQuad(330, 1444, 39, 37, sheetWidth, sheetHeight))
--  self.swirlCount = 10
--  self.swirlFrame = 1
--  self.swrilAnimSpeed = 8
--  self.swirlScale = 0.2
--  self.swirlPos = {{},{},{},{},{},{},{},{},{},{}}
--  self.swirlX = 0
--  self.swirlY = 0
--  self.swirlRadius = 25
--  self.swirlRadians = 0
--  self.swirlMove = 25
  
  -- Spawn Animation
  self.offScreenStart = function()
    return -100,-50
  end
  self.inControlStart = {pTable.x, pTable.y}
  self.controlChange = function(newState)
    self.inControl = newState
  end
  self.aliveChange = function(newState)
    self.isAlive = newState
  end
  self.respawnTween = ""
  self.newTween = function()
    self.respawnTween = Timer.new()
    self.respawnTween:tween(2, self.pos, self.inControlStart, 'linear', self.controlChange)
  end
  
  -- Physics Info
  local physScale = pTable.physScale
  self.phys = HC.rectangle(
    self.x, 
    self.y, 
    pTable.w * self.scaleX * physScale, 
    pTable.h * self.scaleY * physScale)
--  self.phys = HC.circle(
--    self.x, 
--    self.y, 
--    pTable.w * physScale)
  self.phys.name = pTable.name
  

end


function player:update(dt)  
  -- Spawning Cinematic
    if not self.inControl then
      if not self.isAlive then
        self.newTween()
        self.aliveChange(true)
      end
    self.respawnTween:update(dt)
    end
  
  --if controlling character
  -- Movement
  if self.inControl then
    if love.keyboard.isDown("up", "w") and self.y > math.ceil(self.yOriginOffset * self.scaleY) then
      self.y = self.y - self.moveSpeed * dt
      if self.rot > -self.maxRot then
        self.rot = self.rot - dt * self.rotSpeed
      end
    elseif love.keyboard.isDown("down", "s") and self.y < love.graphics.getHeight( ) - math.ceil(self.yOriginOffset * self.scaleY) then
      self.y = self.y + self.moveSpeed * dt
      if self.rot < self.maxRot then
        self.rot = self.rot + dt * self.rotSpeed
      end
    elseif self.rot ~= 0 then
      self.rot = self.rot + dt * -sign(self.rot)
      if math.abs(self.rot) < self.rotTolerance then
        self.rot = 0
      end
    end
    
    --Update Physics
    self.phys:moveTo(self.x, self.y)
    local collisions = HC.collisions(self.phys)
    --Test Collisions    
    for other, delta in pairs(collisions) do
--      debugtext[#debugtext+1] = string.format("Colliding with: %s",other.name)
      if other.name == "pickup1" then
        pickupCount = pickupCount + 1
        other.kill()
      elseif other.name == "blueShip" or other.name == "redShip" then
        self:die()
        other.kill()
        deathCount = deathCount + 1
      elseif other.name == "ground" then
        self:die()
        deathCount = deathCount + 1
      end

      break
    end
    
  end

  --if visible and alive
  if self.isAlive then
    -- Animation
    self.currentFrame = self.currentFrame + self.animationSpeed * dt
    if self.currentFrame >= table.getn(self.frames)+1 then
      self.currentFrame = 1
    end
    
  end
  
  -- Move Swirls

--  self.swirlRadians = self.swirlRadians + dt
--  if self.swirlRadians > math.pi*2 then
--    self.swirlRadians = 0
--  end
--  for i = 1,self.swirlCount do
--    self.swirlPos[i].x = self.x + self.swirlRadius * math.cos((self.swirlRadians + 0.628 * i) + dt * self.swirlMove)
--    self.swirlPos[i].y = self.y + self.swirlRadius * math.sin((self.swirlRadians + 0.628 * i) + dt * self.swirlMove)
--  end

end



function player:draw()
  if self.isAlive then    
    love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.x, self.y, self.rot, self.scaleX, self.scaleY, self.xOriginOffset, self.yOriginOffset)
  
--  for i=1, self.swirlCount do
--        love.graphics.draw(spritesheet, self.swirlFrames[math.floor(self.swirlFrame)], self.swirlPos[i].x, self.swirlPos[i].y, 0, self.swirlScale, self.swirlScale)
--  end

  
  -- Physics debug
    love.graphics.setColor(255,0,0)
    self.phys:draw('line')
    love.graphics.setColor(255,255,255)
  end
end

function player:die()
  self.aliveChange(false)
  self.controlChange(false)
  particleController:emit("playerDeath",10,self.x,self.y)
  self.x, self.y = self.offScreenStart()
  self.rot = 0
  self.phys:moveTo(self.x, self.y)
end

function sign(x)
  if x<0 then
    return -1
  else
    return 1
  end
end

return player
