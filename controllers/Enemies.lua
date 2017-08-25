local Class = require 'libs.hump.class'
local style1 = require 'templates.enemyStyle1'

local Enemies = Class{
}

function Enemies:init()
  self.enemyList = {}
  self.enemyList.e1List = {}
  self.enemy1 = require 'entities.enemy1'
--  self.enemyList.e2List = {}
  local en = style1(self.enemy1)
  table.insert(self.enemyList.e1List, en)
  UpdateList:add(self.enemyList.e1List[1], 2)
  self:spawnControl()
end

function Enemies:addMore(etype)
  local en = style1(self.enemy1)
  table.insert(etype, en)
  UpdateList:add(etype[#etype], 2)
  en:activate()
end

function Enemies:spawnEnemy(etype)
  local found = false
  for i,e in pairs(etype) do
    if e.active == false then
      e:activate()
      found = true
      break
    end
  end
  if found == false then
    self:addMore(etype)
  end
end

function Enemies:spawnControl()
    local t = math.random(0.5,1.1)
  Timer.after(t, function() self:spawnEnemy(self.enemyList.e1List) self:spawnControl() end)
end
  

return Enemies