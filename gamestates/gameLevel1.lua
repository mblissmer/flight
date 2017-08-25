
Gamestate = require 'libs.hump.gamestate'
UpdateList = require 'utils.UpdateList'
Timer = require "libs.hump.timer"

local Backgrounds = require 'controllers.Backgrounds'

local Enemies = require 'controllers.Enemies'
local Particles = require 'controllers.Particles'

local gameLevel1 = {}

local Player = require 'entities.player'

local text = {}

function gameLevel1:enter()
  UpdateList:enter()
  Backgrounds:enter(self:createBackgroundsTable())
  enemyController = Enemies()
  
  local player = Player(100, 50, exp)
  UpdateList:add(Backgrounds,1)
  UpdateList:add(player,2)
  
  -- Do particles last so they end up on top of layers visually
  particleController = Particles()
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
  Timer.update(dt)
  
  while #text > 40 do
    table.remove(text, 1)
  end
  text[#text+1] = string.format("Enemy Count: %s",#enemyController.enemyList.e1List )
end

function gameLevel1:draw()
  UpdateList:draw()
  
  for i = 1,#text do
      love.graphics.setColor(0,0,0, 255 - (i-1) * 6)
      love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end
  love.graphics.setColor(255,255,255)
  
end

function gameLevel1:createBackgroundsTable()
  local bgtable = {}
  table.insert(bgtable, require('entities.bgFar'))
  table.insert(bgtable, require('entities.bgNear'))
  return bgtable
end

return gameLevel1
