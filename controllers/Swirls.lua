local Class = require 'libs.hump.class'

local Swirls = Class{
}

function Swirls:init(ul)
end

function Swirls:addMore(swirl)
  local sw = swirl.style(swirl.template)
  table.insert(swirl.list, sw)
  self.updateList:add(swirl.list[#swirl.list], 2)
  return sw
end

function Swirls:spawnEnemy(swirl)
  local found = false
  for i,s in pairs(enemy.list) do
    if s.active == false then
      s:activate(y)
      found = true
      break
    end
  end
  if found == false then
    self:addMore(swirl):activate()
  end
end

return Swirls