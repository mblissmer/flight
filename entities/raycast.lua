local Class = require 'libs.hump.class'

local Rcast = Class{
}

function worldRayCastCallback(fixture, x, y, xn, yn, fraction)
	local hit = {}
	hit.fixture = fixture
	hit.x, hit.y = x, y
	hit.xn, hit.yn = xn, yn
	hit.fraction = fraction
  print "hit"
 
	table.insert(self.ray.hitList, hit)
 
	return 1
end

function Rcast:init(width, height, xAxisRayNum, yAxisRayNum, skinWidth, rayLength)
--  self.width = width
--  self.height = height
  self.xAxisRayNum = xAxisRayNum
  self.yAxisRayNum = yAxisRayNum
  self.skinWidth = skinWidth
  self.rayLength = rayLength
  self.xRaySpacing = (width - (2*skinWidth)) / (xAxisRayNum - 1)
  self.yRaySpacing = (height - (2*skinWidth)) / (yAxisRayNum - 1)
  self.xRays = {}
  self.yRays = {}
  self.isHit = false
  self.ray = {
		x1 = 0,
		y1 = 0,
		x2 = 0,
		y2 = 0,
		hitList = {}
	}
end

function Rcast:update(x,y)
  self.ray.hitList = {}
  for i = 1,self.xAxisRayNum do
    x1 = x + self.skinWidth + ((i-1) * self.xRaySpacing)
    y1 = y  + self.skinWidth
    y2 = y1 - self.rayLength
    self.world:rayCast(x1, y1, x1, y2, worldRayCastCallback)
  end
  
end

function Rcast:draw(x,y)
  love.graphics.setColor(255,0,0)
  for i = 1,self.xAxisRayNum do
    x1 = x + self.skinWidth + ((i-1) * self.xRaySpacing)
    y1 = y  + self.skinWidth
    y2 = y1 - self.rayLength
    self.xRays[i] = love.graphics.line(x1,y1,x1,y2)
  end
  for i = 1,self.yAxisRayNum do
    y1 = y + self.skinWidth + ((i-1) * self.yRaySpacing)
    x1 = x  + self.skinWidth
    x2 = x1 - self.rayLength
    self.xRays[i] = love.graphics.line(x1,y1,x2,y1)
  end
  love.graphics.setColor(255,255,255)
end



return Rcast