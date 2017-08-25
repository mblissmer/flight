local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'

local particleSystem = Class{
  __includes = Entity
}

function particleSystem:init(pTable)
  self.ps = pTable.ps
  self.name = pTable.name
  Entity.init(self,0,0,1,1)
end

function particleSystem:update(dt)
  self.ps:update(dt)
end

function particleSystem:draw()
  love.graphics.draw(self.ps)
end

return particleSystem
