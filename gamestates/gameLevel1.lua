
Gamestate = require 'libs.hump.gamestate'

local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

local gameLevel1 = {}


local Player = require 'entities.player'
local Bg = require 'entities.background'
local Enemy = require 'entities.enemy'
local Explosion = require 'entities.explosion'

function gameLevel1:enter()
  Entities:enter()
  background = Bg(0,0)
  enemy = Enemy(200,200)
  exp = Explosion(0,0)
  
  player = Player(100, 50, exp)
  Entities:addMany({background, player, enemy, exp})
end

function gameLevel1:update(dt)
  Entities:update(dt)
end

function gameLevel1:draw()
  Entities:draw()
end

return gameLevel1
