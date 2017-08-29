local Class = require 'libs.hump.class'
local style1 = require 'templates.objectStyle1'

local Pickups = Class{
}

function Pickups:init()
  self.pickup1 = {}
  self.pickup1.list = {}
  self.pickup1.template = require 'entities.pickup1'
  self.pickup1.style = style1
  self:spawnPickup1()
end

function Pickups:addMore(pickup)
  local pu = pickup.style(pickup.template)
  table.insert(pickup.list, pu)
  UpdateList:add(pickup.list[#pickup.list], 2)
  return pu
end

function Pickups:spawnPickup(pickup)
  local found = false
  for i,p in pairs(pickup.list) do
    if p.active == false then
      p:activate()
      found = true
      break
    end
  end
  if found == false then
    self:addMore(pickup):activate()
  end
end

function Pickups:spawnPickup1()
    local t = math.random(0.5,1.1)
  Timer.after(t, function() self:spawnPickup(self.pickup1) self:spawnPickup1() end)
end

return Pickups