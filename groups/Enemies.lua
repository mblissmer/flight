local enemy1 = require 'entities.enemy1'

local Enemies = {
  active = true,
  enemyList = {}
}

function Enemies:enter(etable)
  self.enemyList = {}
  for i, en in ipairs(etable) do
    local enemy = enemy1(en.x, en.y, en.w, en.h, en.scale, en.speed, en.animTable, en.animSpeed)
    table.insert(self.backgroundList, enemy)
  end
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