local Entity = require 'entities.Entity'
local Class = require 'libs.hump.class'
local Enemy = require 'entities.enemy'

local Enemies = Class{
  __includes = Entity
  active = true,
  enemyList - {}
}

function Enemies:init(enemyTable)
  for enemy, quantity in ipairs(enemyTable) do
    for i=1,quantity do
      local new = Enemy(200,200)
      self:add(new)
    end
  end
  Entity.init(self, 0,0,0,0)
end

function Enemies:enter()
  self:clear()
end

function Enemies:add(enemy)
  table.insert(self.enemyList, enemy)
end

function Enemies:addMany(enemies)
  for k, enemy in pairs(enemies) do
    table.insert(self.enemyList, enemy)
  end
end

function Enemies:remove(enemy)
  for i, e in ipairs(self.enemyList) do
    if e == enemy then
      table.remove(self.enemyList, i)
      return
    end
  end
end

function Enemies:removeAt(index)
  table.remove(self.enemyList, index)
end

function Enemies:clear()
  self.enemyList = {}
end

function Enemies:draw()
  for i, e in ipairs(self.enemyList) do
    e:draw(i)
  end
end

function Enemies:update(dt)
  for i, e in ipairs(self.enemyList) do
    e:update(dt, i)
  end
end

return Enemies
