local Class = require 'libs.hump.class'
local style1 = require 'templates.objectStyle1'

local Enemies = Class{
}

function Enemies:init(ul)
  self.yellowPlane = {}
  self.yellowPlane.list = {}
  self.yellowPlane.template = require 'entities.enemy1'
  self.yellowPlane.style = style1
  
  self.redPlane = {}
  self.redPlane.list = {}
  self.redPlane.template = require 'entities.enemy2'
  self.redPlane.style = style1
  
  self.updateList = ul
end

function Enemies:addMore(enemy)
  local en = enemy.style(enemy.template)
  table.insert(enemy.list, en)
  self.updateList:add(enemy.list[#enemy.list], 2)
  return en
end

function Enemies:spawnEnemy(enemy, y)
  local found = false
  for i,e in pairs(enemy.list) do
    if e.active == false then
      e:activate(y)
      found = true
      break
    end
  end
  if found == false then
    self:addMore(enemy):activate(y)
  end
end

return Enemies