local img = love.graphics.newImage("assets/explosion04.png")
local maxParticles = 32
local p = love.graphics.newParticleSystem(img, maxParticles)
p:setParticleLifetime(1,2)
p:setSpeed(50,75)
p:setRotation(0,3)
p:setSizes(0.1,0.2)
p:setColors(255,255,255,255,255,255,255,0)
p:setDirection(1.5)
p:setParticleLifetime( 0.25, 0.5 )
local table = {}
table.ps = p
table.name = "playerDeath"
table.draw = function()
  love.graphics.draw(self.ps)
end
return table