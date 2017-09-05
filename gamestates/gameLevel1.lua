
local Gamestate = require 'libs.hump.gamestate'
local UpdateList = require 'utils.UpdateList'
Camera = require 'libs.hump.camera'
require 'libs.gooi'

local Backgrounds = require 'controllers.Backgrounds'
local Enemies = require 'controllers.Enemies'
local Particles = require 'controllers.Particles'
local Pickups = require 'controllers.Pickups'
local Patterns = require 'controllers.Patterns'

local gameLevel1 = {}

local Player = require 'templates.playerObject'

local src1 = love.audio.newSource('assets/seafloor.mp3')
local noAudio = 0
sampleCount = 0

debugtext = {}

local times = {}
local yPos = 100

pickupCount = 0
deathCount = 0



function gameLevel1:enter()
  UpdateList:enter()
  enemyController = Enemies(UpdateList)
  pickupController = Pickups(UpdateList)
  backgroundController = Backgrounds(UpdateList)
  patternController = Patterns(require 'patterns.g1')
  
  player = Player(require 'entities.player')
  UpdateList:add(player,2)
  UpdateList:add(patternController,1)
  
  -- Do particles last so they end up on top of layers visually
  particleController = Particles(UpdateList)
  
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
  
  camera = Camera()
end

function gameLevel1:leave()
  UpdateList:removeAll()
  gooi.components = {}
  Timer.clear()
end

function gameLevel1:update(dt)
  UpdateList:update(dt)
  Timer.update(dt)
  
  deathCountGui:setText(deathCount)
  pickupCountGui:setText(pickupCount)
  
  gooi.update(dt)
  
--  camera.y = player.pos.y

  -- Debug Info
  while #debugtext > 40 do
    table.remove(debugtext, 1)
  end
--  debugtext[#debugtext+1] = string.format("Enemy Count: %s, %s",#enemyController.yellowPlane.list, #enemyController.redPlane.list )
--  debugtext[#debugtext+1] = string.format("Audio Position: %.2f",src1:tell("samples"))
  if src1:tell("samples") == 0 then
    noAudio = noAudio + 44100 * dt
  end
  sampleCount = src1:tell("samples") + math.floor(noAudio)
end

function gameLevel1:draw()
  camera:attach()
  UpdateList:draw()
  for i = 1,#debugtext do
      love.graphics.setColor(0,0,0, 255 - (i-1) * 6)
      love.graphics.print(debugtext[#debugtext - (i-1)], 10, i * 15)
    end
  love.graphics.setColor(255,255,255)
  camera:detach()
  gooi.draw()
end

function gameLevel1:quit()
  if times[1] then
    local timefile = io.open("output/output.txt","w")
    local st = ""
    for i, t in pairs(times) do
      for j, e in pairs(t) do
        st = st .. j .. "=" .. e .. ", "
      end
      st = st .. "\n"
    end
    timefile:write(st)
    timefile:close()
  end
end

function gameLevel1:keypressed(key)
  if key == "1" or key == "2" or key == "3" then
    local samples = src1:tell("samples") + math.floor(noAudio)
    table.insert(times, {sample=samples,otype=key,y=yPos})
    yPos = yPos + 111
    if yPos > screenHeight-100 then
      yPos = 100
    end
  end
end

return gameLevel1
