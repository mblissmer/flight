
Gamestate = require 'libs.hump.gamestate'
UpdateList = require 'utils.UpdateList'
Timer = require "libs.hump.timer"
require 'libs.gooi'

local Backgrounds = require 'controllers.Backgrounds'
local Enemies = require 'controllers.Enemies'
local Particles = require 'controllers.Particles'
local Pickups = require 'controllers.Pickups'

local gameLevel1 = {}

local Player = require 'entities.player'

local src1 = love.audio.newSource('assets/seafloor.mp3')

debugtext = {}

local times = {}

pickupCount = 0
deathCount = 0



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
      
  local panelGrid = gooi.newPanel({
    x=screenWidth-100, 
    y=0, 
    w=100, 
    h=50, 
    layout="grid 2x2"})
  deathCountGui = gooi.newLabel(
    {text = "0"})
    :fg({0,0,0})
  pickupCountGui = gooi.newLabel(
    {text = "0"})
    :fg({0,0,0})

	panelGrid:add(
    gooi.newLabel({text = "Pickups:"}):fg({0,0,0}),
    pickupCountGui,
    gooi.newLabel({text = "Deaths:"}):fg({0,0,0}),
    deathCountGui
    )
  
end

function gameLevel1:leave()
  UpdateList:RemoveAll()
  gooi.components = {}
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
  Timer.update(dt)
  
  deathCountGui:setText(deathCount)
  pickupCountGui:setText(pickupCount)
  
  gooi.update(dt)
  
  -- Debug Info
  while #debugtext > 40 do
    table.remove(debugtext, 1)
  end
--  debugtext[#text+1] = string.format("Enemy Count: %s, %s",#enemyController.yellowPlane.list, #enemyController.redPlane.list )
--  debugtext[#text+1] = string.format("Audio Position: %.2f",src1:tell("samples"))
end

function gameLevel1:draw()
  UpdateList:draw()
  for i = 1,#debugtext do
      love.graphics.setColor(0,0,0, 255 - (i-1) * 6)
      love.graphics.print(debugtext[#debugtext - (i-1)], 10, i * 15)
    end
  love.graphics.setColor(255,255,255)
  gooi.draw()
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

return gameLevel1
