
Gamestate = require 'libs.hump.gamestate'
UpdateList = require 'utils.UpdateList'
Timer = require "libs.hump.timer"
suit = require 'libs.suit'

local Backgrounds = require 'controllers.Backgrounds'
local Enemies = require 'controllers.Enemies'
local Particles = require 'controllers.Particles'
local Pickups = require 'controllers.Pickups'

local gameLevel1 = {}

local Player = require 'entities.player'

local src1 = love.audio.newSource('assets/seafloor.mp3')

debugtext = {}

local times = {}



function gameLevel1:enter()
  UpdateList:enter()
  enemyController = Enemies()
  pickupController = Pickups()
  backgroundController = Backgrounds()
  
  local player = Player(100, 50, exp)
  UpdateList:add(player,2)
  
  -- Do particles last so they end up on top of layers visually
  particleController = Particles()
  
  src1:play()
  
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
  Timer.update(dt)
  suit.layout:reset(screenWidth-200,50)
  suit.layout:padding(20,20)
  suit.Label("Stars Collected", {align="right"},suit.layout:row(100,30))
  suit.Label("2", suit.layout:col())
  suit.Label("Deaths", {align="right",color={255,0,0}},suit.layout:row(100,30))
  suit.Label("2", suit.layout:col())
    
  -- Debug Info
  while #debugtext > 40 do
    table.remove(debugtext, 1)
  end
--  debugtext[#text+1] = string.format("Enemy Count: %s, %s",#enemyController.yellowPlane.list, #enemyController.redPlane.list )
--  debugtext[#text+1] = string.format("Audio Position: %.2f",src1:tell("samples"))
end

function gameLevel1:draw()
  UpdateList:draw()
  suit.draw()
  for i = 1,#debugtext do
      love.graphics.setColor(0,0,0, 255 - (i-1) * 6)
      love.graphics.print(debugtext[#debugtext - (i-1)], 10, i * 15)
    end
  love.graphics.setColor(255,255,255)
  
end

function gameLevel1:quit()
  if times[1] then
    local timefile = io.open("output/output.csv","w")
    local st = ""
    for i, t in pairs(times) do
      st = st .. t .. ","
    end
    timefile:write(st)
    timefile:close()
  end
end

function gameLevel1:keypressed(key)
  if key == "space" then
    table.insert(times, src1:tell("samples"))
  end
end

function gameLevel1:createBackgroundsTable()
  local bgtable = {}
  table.insert(bgtable, require('entities.bgFar'))
  table.insert(bgtable, require('entities.bgNear'))
  return bgtable
end

return gameLevel1
