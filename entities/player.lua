
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'
local HC = require 'libs.HC'
local Timer = require 'libs.hump.timer'

local player = Class{
  __includes = Entity
}


local text = {}
function player:init(x, y, explosion)
  -- Properties
  self.inControl = true
  self.isAlive = true
  self.frame_width = 87
  self.frame_height = 72
  self.xOriginOffset = self.frame_width / 2
  self.yOriginOffset = self.frame_height / 2
  self.pos = {x = x, y = y}
  self.startX = x
  self.startY = y
  self.rot = 0
  self.maxRot = .2
  self.rotSpeed = 5
  self.rotTolerance = .1
  self.scale = .5
  self.moveSpeed = 300
  
  -- Animation Info
  self.frames = {}
  table.insert(self.frames, love.graphics.newQuad(330, 1371, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(372, 1132, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(222, 1562, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  table.insert(self.frames, love.graphics.newQuad(372, 1132, self.frame_width, self.frame_height, sheetWidth, sheetHeight))
  self.currentFrame = 1
  self.animationSpeed = 8
  
  -- Spawn Animation
  self.offScreenStart = function()
    return {x = -100,y = -50}
  end
  
  self.inControlStart = {x = self.startX, y = self.startY}
  
  
  
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
  self.rect = HC.rectangle(self.pos.x,self.pos.y,self.frame_width * self.scale ,self.frame_height * self.scale)
  
  -- Particle System
  local img = love.graphics.newImage("assets/whitePuff06.png")
  self.exhaust = love.graphics.newParticleSystem(img, 32)
  self.exhaust:setParticleLifetime(1,2)
  self.exhaust:setSpeed(50,75)
  self.exhaust:setRotation(0,3)
  self.exhaust:setSizes(0.01,0.05)
  self.exhaust:setColors(255,255,255,255,255,255,255,0)
  self.exhaust:setDirection(3)
  self.exhaust:setParticleLifetime( 0.25, .5 )
  self.emitSpeed = .25
  self.emitTimer = self.emitSpeed
  
  self.explosion = explosion
  
  -- Init Class
  Entity.init(self, x, y, self.frame_width, self.frame_height)
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
    if love.keyboard.isDown("left", "a") and self.pos.x > math.ceil(self.xOriginOffset * self.scale) then
      self.pos.x = self.pos.x - self.moveSpeed * dt
    elseif love.keyboard.isDown("right", "d") and self.pos.x < love.graphics.getWidth( ) - math.ceil(self.xOriginOffset * self.scale) then
      self.pos.x = self.pos.x + self.moveSpeed * dt
    end
    
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
  end

  --if visible and alive

  if self.isAlive then
    
    -- Animation
    self.currentFrame = self.currentFrame + self.animationSpeed * dt
    if self.currentFrame >= table.getn(self.frames)+1 then
      self.currentFrame = 1
    end
    
    --Update Physics
    self.rect:moveTo(self.pos.x, self.pos.y)
    local collisions = HC.collisions(self.rect)
    --Test Collisions    
    for shape, delta in pairs(collisions) do
        self.aliveChange(false)
        self.controlChange(false)
        self.explosion:boom(self.pos.x,self.pos.y)
        self.pos = self.offScreenStart()
        break
    end
    
--    while #text > 40 do
--      table.remove(text, 1)
--    end
    -- Update Particles
    
    self.exhaust:moveTo(self.pos.x, self.pos.y)
    self.emitTimer = self.emitTimer + dt
    if self.emitTimer >= self.emitSpeed then
      self.exhaust:emit(5)
      self.emitTimer = 0
    end
    
  end
  
  -- HAPPENS REGARDLESS
  self.exhaust:update(dt)
  
--  text[#text+1] = string.format("End of update. XY: %.0f, %.0f",self.pos.x, self.pos.y)
end



function player:draw()
  if self.isAlive then
    love.graphics.draw(self.exhaust)
    
    love.graphics.draw(spritesheet, self.frames[math.floor(self.currentFrame)], self.pos.x, self.pos.y, self.rot, self.scale, self.scale, self.xOriginOffset, self.yOriginOffset)
--    for i = 1,#text do
--      love.graphics.setColor(0,0,0, 255 - (i-1) * 6)
--      love.graphics.print(text[#text - (i-1)], 10, i * 15)
--    end
    love.graphics.setColor(255,255,255)
  end
end

function sign(x)
  if x<0 then
    return -1
  else
    return 1
  end
end

return player
