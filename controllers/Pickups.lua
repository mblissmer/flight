local Class = require 'libs.hump.class'
local style1 = require 'templates.objectStyle1'

local Pickups = Class{
}

function Pickups:init(ul)
  self.pickup1 = {}
  self.pickup1.list = {}
  self.pickup1.template = require 'entities.pickup1'
  self.pickup1.style = style1
  self.updateList = ul
end

function Pickups:addMore(pickup)
  local pu = pickup.style(pickup.template)
  table.insert(pickup.list, pu)
  self.updateList:add(pickup.list[#pickup.list], 2)
  return pu
end

function Pickups:spawnPickup(pickup, y)
  local found = false
  for i,p in pairs(pickup.list) do
    if p.active == false then
      p:activate(y)
      found = true
      break
    end
  end
  if found == false then
    self:addMore(pickup):activate(y)
  end
end

return Pickups