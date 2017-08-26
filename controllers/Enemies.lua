local Class = require 'libs.hump.class'
local style1 = require 'templates.enemyStyle1'

local Enemies = Class{
}

function Enemies:init()
  self.yellowPlane = {}
  self.yellowPlane.list = {}
  self.yellowPlane.template = require 'entities.enemy1'
  self.yellowPlane.style = style1
  
  self.redPlane = {}
  self.redPlane.list = {}
  self.redPlane.template = require 'entities.enemy2'
  self.redPlane.style = style1
  
  self:spawnYellowPlane()
  self:spawnRedPlane()
end

function Enemies:addMore(enemy)
  local en = enemy.style(enemy.template)
  table.insert(enemy.list, en)
  UpdateList:add(enemy.list[#enemy.list], 2)
  return en
end

function Enemies:spawnEnemy(enemy)
  local found = false
  for i,e in pairs(enemy.list) do
    if e.active == false then
      e:activate()
      found = true
      break
    end
  end
  if found == false then
    self:addMore(enemy):activate()
  end
end

function Enemies:spawnYellowPlane()
    local t = math.random(0.5,1.1)
  Timer.after(t, function() self:spawnEnemy(self.yellowPlane) self:spawnYellowPlane() end)
end
  
function Enemies:spawnRedPlane()
    local t = math.random(2,3)
  Timer.after(t, function() self:spawnEnemy(self.redPlane) self:spawnRedPlane() end)
end  

return Enemies