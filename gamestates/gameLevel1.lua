
Gamestate = require 'libs.hump.gamestate'

UpdateList = require 'utils.UpdateList'
local Backgrounds = require 'groups.Backgrounds'
local Enemies = require 'groups.Enemies'

local gameLevel1 = {}

local Player = require 'entities.player'
local Enemy = require 'entities.enemy'
local Explosion = require 'entities.explosion'

function gameLevel1:enter()
  UpdateList:enter()
  Backgrounds:enter(self:createBackgroundsTable())
  Enemies:enter(self:createEnemyList())
--  local enemy = Enemy(200,200)
  local exp = Explosion(0,0)
  
  local player = Player(100, 50, exp)
  UpdateList:addMany({Backgrounds, player, Enemies, exp})
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
end

function gameLevel1:draw()
  UpdateList:draw()
end

function gameLevel1:createBackgroundsTable()
  local bgtable = {}
  local nearHeightTable = {30,30,30,40,60,60,40,40,50,30,20,20,20,40,60,30}
  local near = {x=0,y=screenHeight-71,w=799,h=71,quadX=0,quadY=0,speed=200,colColWidth=50,colsHeightTable=nearHeightTable}
  local far = {x=0,y=0,w=799,h=480,quadX=0,quadY=355,speed=40}
  table.insert(bgtable, far)
  table.insert(bgtable, near)
  return bgtable
end

function gameLevel1:createEnemyList()
  local enemyTable = {}
  local enemy1anim = {{304,1967},{330,1298},{330,1225},{330,1298}}
  local enemy1 = {x=200,y=200,w=88,h=73,scale=0.5,speed=20,animTable=enemy1anim, animSpeed=8}
  -- enemy1(en.x, en.y, en.w, en.h, en.scale, en.speed, en.animTable, en.animSpeed)
  return enemyTable
end

return gameLevel1
