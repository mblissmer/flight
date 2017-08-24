local Class = require 'libs.hump.class'
local style1 = require 'templates.enemyStyle1'

local Enemies = Class{
}

function Enemies:init()
  self.enemyList = {}
  self.enemyList.e1List = {}
--  self.enemyList.e2List = {}
  en = style1(require('entities.enemy1'))
  table.insert(self.enemyList.e1List, en)
  UpdateList:add(self.enemyList.e1List[1], 2)
end

function Enemies:addMore(n)
  
end

return Enemies