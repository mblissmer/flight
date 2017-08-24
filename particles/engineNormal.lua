local img = love.graphics.newImage("assets/whitePuff06.png")
local maxParticles = 32
local p = love.graphics.newParticleSystem(img, maxParticles)
p:setParticleLifetime(1,2)
p:setSpeed(50,75)
p:setRotation(0,3)
p:setSizes(0.01,0.05)
p:setColors(255,255,255,255,255,255,255,0)
p:setDirection(3)
p:setParticleLifetime( 0.25, .5 )
local table = {}
table.ps = p
table.name = "engineNormal"
table.speed = .25
table.timer = 0
return table