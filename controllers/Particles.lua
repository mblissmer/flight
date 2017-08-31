
local Class = require 'libs.hump.class'
local Particles = require 'templates.particleObject'
local UpdateList = require 'utils.UpdateList'

local particleController = Class{
}

function particleController:init(ul)
  self.particleSystems = {}
  self.playerDeath1 = Particles(require('particles.playerDeath'))
  self.engineNormal = Particles(require('particles.engineNormal'))
  table.insert(self.particleSystems, self.playerDeath1)
  table.insert(self.particleSystems, self.engineNormal)
  ul:add(self.playerDeath1,5)
  ul:add(self.engineNormal,1)
end

function particleController:emit(name,amount,x,y)
  for i, e in ipairs(self.particleSystems) do
    if e.name == name then
      e.ps:moveTo(x,y)
      e.ps:emit(amount)
    end
  end
end

return particleController
