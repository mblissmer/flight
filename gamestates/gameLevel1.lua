
Gamestate = require 'libs.hump.gamestate'

UpdateList = require 'utils.UpdateList'
local Backgrounds = require 'controllers.Backgrounds'
local Enemies = require 'controllers.Enemies'
local Particles = require 'controllers.Particles'

local gameLevel1 = {}

local Player = require 'entities.player'

function gameLevel1:enter()
  UpdateList:enter()
  Backgrounds:enter(self:createBackgroundsTable())
  Enemies:enter(self:createEnemyList())
  
  local player = Player(100, 50, exp)
  UpdateList:add(Backgrounds,1)
  UpdateList:add(player,2)
  UpdateList:add(Enemies,2)
  
  -- Do particles last so they end up on top of layers visually
  particleController = Particles()
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
end

function gameLevel1:draw()
  UpdateList:draw()
end

function gameLevel1:createBackgroundsTable()
  local bgtable = {}
  table.insert(bgtable, require('entities.bgFar'))
  table.insert(bgtable, require('entities.bgNear'))
  return bgtable
end

function gameLevel1:createEnemyList()
  local enemyTable = {}
  table.insert(enemyTable, require('entities.enemy1'))
  return enemyTable
end

return gameLevel1
