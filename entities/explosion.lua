
local Class = require 'libs.hump.class'
local Entity = require 'entities.Entity'

local explosion = Class{
  __includes = Entity
}


function explosion:init(x, y)
  local img = love.graphics.newImage("assets/explosion04.png")
  self.explosion = love.graphics.newParticleSystem(img, 32)
  self.explosion:setParticleLifetime(1,2)
  self.explosion:setSpeed(50,75)
  self.explosion:setRotation(0,3)
  self.explosion:setSizes(0.1,0.5)
  self.explosion:setColors(255,255,255,255,255,255,255,0)
  self.explosion:setDirection(1.5)
  self.explosion:setParticleLifetime( 0.25, 0.5 )
  
  -- Init Class
  Entity.init(self, x, y, 1,1)
end


function explosion:update(dt)
  self.explosion:update(dt)
end


function explosion:boom(x,y)
  self.explosion:moveTo(x,y)
  self.explosion:emit(10)
end

function explosion:draw()
  love.graphics.draw(self.explosion)
end


return explosion
