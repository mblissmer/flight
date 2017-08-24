local Class = require 'libs.hump.class'
local Entity = require 'templates.Entity'

local particleSystem = Class{
  __includes = Entity
}

function particleSystem:init(table)
  self.ps = table.ps
  self.name = table.name
  Entity.init(self,0,0,1,1)
end

function particleSystem:update(dt)
  self.ps:update(dt)
end

function particleSystem:draw()
  love.graphics.draw(self.ps)
end

return particleSystem
