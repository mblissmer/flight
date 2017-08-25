local enemy1 = require 'templates.enemyStyle1'

local Enemies = {
  active = true,
  enemyList = {}
}

function Enemies:enter(etable)
  self.enemyList = {}
  for i, en in pairs(etable) do
    local enemy = enemy1(en.x, en.y, en.w, en.h, en.scale, en.speed, en.animTable, en.animSpeed)
    table.insert(self.enemyList, enemy)
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