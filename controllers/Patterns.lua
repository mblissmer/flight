local Class = require 'libs.hump.class'
local style1 = require 'templates.objectStyle1'

local Patterns = Class{
}

function Patterns:init(pattern)
  self.pattern = pattern
  self.startPoint = 1
  
end 

function Patterns:update(dt)
  for i = self.startPoint, #self.pattern do
    if self.pattern[i]["sample"] < sampleCount then
      self:spawn(self.pattern[i])
      self.startPoint = i + 1
    else 
      break
    end
  end
end 

function Patterns:spawn(object)
  if object["otype"] == 3 then
    enemyController:spawnEnemy(enemyController.redPlane, object["y"])
  elseif object["otype"] == 2 then
    enemyController:spawnEnemy(enemyController.yellowPlane, object["y"])
  elseif object["otype"] == 1 then
    pickupController:spawnPickup(pickupController.pickup1, object["y"])
  end
end


function Patterns:draw()
  -- nothing to draw, leave this blank. kthx
end 

return Patterns