
local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'
local HC = require 'libs.hc'

local player = Class{
  __includes = Entity
}



function player:init(x, y)
  -- Properties
  self.inControl = true
  self.isAlive = true
  local frame_width = 87
  local frame_height = 72
  self.xOriginOffset = frame_width / 2
  self.yOriginOffset = frame_height / 2
  self.pos = {x = x, y = y}
  self.rot = 0
  self.maxRot = 0.2
  self.rotSpeed = 5
  self.rotTolerance = 0.1
  self.scale = 0.5
  self.moveSpeed = 300
  
  -- Animation Info
  self.frames = {}
  table.insert(self.frames, love.graphics.newQuad(330, 1371, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(222, 1562, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
  self.currentFrame = 1
  self.animationSpeed = 8
  
  -- Spawn Animation
  self.offScreenStart = function()
    return {x = -100,y = -50}
  end
  self.inControlStart = {x = x, y = y}
  self.controlChange = function(newState)
    self.inControl = newState
  end
  self.aliveChange = function(newState)
    self.isAlive = newState
  end
  self.respawnTween = ""
  self.newTween = function()
    self.respawnTween = Timer.new()
    self.respawnTween:tween(2, self.pos, {x = self.inControlStart.x, y = self.inControlStart.y}, 'linear', self.controlChange)
  end
  
  -- Physics Info
  local physScale = 0.2
--  self.phys = HC.rectangle(
--    self.pos.x, 
--    self.pos.y, 
--    frame_width * self.scale * physScale, 
--    frame_height * self.scale * physScale)
  self.phys = HC.circle(
    self.pos.x, 
    self.pos.y, 
    frame_width * physScale)
  
  -- Exhaust Speed
  self.exhaustSpeed = .25
  self.exhaustTimer = 0
  
  -- Init Class
  Entity:init(x, y, frame_width, frame_height)
end


function player:update(dt)
  
--  text[#text+1] = string.format("Beginning of update. XY: %.0f, %.0f",self.pos.x, self.pos.y)
  
  
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
--    if love.keyboard.isDown("left", "a") and self.pos.x > math.ceil(self.xOriginOffset * self.scale) then
--      self.pos.x = self.pos.x - self.moveSpeed * dt
--    elseif love.keyboard.isDown("right", "d") and self.pos.x < love.graphics.getWidth( ) - math.ceil(self.xOriginOffset * self.scale) then
--      self.pos.x = self.pos.x + self.moveSpeed * dt
--    end
    
    if love.keyboard.isDown("up", "w") and self.pos.y > math.ceil(self.yOriginOffset * self.scale) then
      self.pos.y = self.pos.y - self.moveSpeed * dt
      if self.rot > -self.maxRot then
        self.rot = self.rot - dt * self.rotSpeed
      end
    elseif love.keyboard.isDown("down", "s") and self.pos.y < love.graphics.getHeight( ) - math.ceil(self.yOriginOffset * self.scale) then
      self.pos.y = self.pos.y + self.moveSpeed * dt
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
    self.phys:moveTo(self.pos.x, self.pos.y)
    local collisions = HC.collisions(self.phys)
    --Test Collisions    
    for other, delta in pairs(collisions) do
--      debugtext[#debugtext+1] = string.format("Colliding with: %s",other.name)
      if other.name == "pickup1" then
        pickupCount = pickupCount + 1
        other.kill()
      elseif other.name == "yellowPlane" or other.name == "redPlane" then
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

    -- Update Particles
    
--    self.exhaust:moveTo(self.pos.x, self.pos.y)
    self.exhaustTimer = self.exhaustTimer + dt
    if self.exhaustTimer >= self.exhaustSpeed then
      particleController:emit("engineNormal",5,self.pos.x,self.pos.y)
      self.exhaustTimer = 0
    end
    
  end

end



function player:draw()
  if self.isAlive then    
    love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.pos.x, self.pos.y, self.rot, self.scale, self.scale, self.xOriginOffset, self.yOriginOffset)
  
  -- Physics debug
--    love.graphics.setColor(255,0,0)
--    self.phys:draw('line')
--    love.graphics.setColor(255,255,255)
  end
end

function player:die()
  self.aliveChange(false)
  self.controlChange(false)
  particleController:emit("playerDeath",10,self.pos.x,self.pos.y)
  self.pos = self.offScreenStart()
  self.rot = 0
  self.phys:moveTo(self.pos.x, self.pos.y)
end

function sign(x)
  if x<0 then
    return -1
  else
    return 1
  end
end

return player
