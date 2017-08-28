suit = require 'libs.suit'

local mainMenu = {}

local input = {text = ""}
local playerImage = {}
local animationSpeed = 8
local currentFrame = 1
local playerScale = 2

function mainMenu:enter()
  local frame_width = 87
  local frame_height = 72
  table.insert(playerImage, love.graphics.newQuad(330, 1371, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(222, 1562, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
end

function mainMenu:update(dt)
  suit.layout:reset(50,50)
  suit.layout:padding(20,20)
  suit.Label("Helicopter Game!", {align="left"},suit.layout:row(200,30))
  if suit.Button("New Game", suit.layout:row()).hit then
    switchGamestates("gameLevel1")
  end
  if suit.Button("Exit", suit.layout:row()).hit then
    love.event.push("quit")
  end
  
  currentFrame = currentFrame + animationSpeed * dt
    if currentFrame >= table.getn(playerImage)+1 then
      currentFrame = 1
    end
end

function mainMenu:draw()
  suit.draw()
  
  love.graphics.draw(spritesheet, playerImage[math.floor(currentFrame)], screenWidth/2, screenHeight/2, 0, playerScale, playerScale)
end

function mainMenu:textinput(t)
    suit.textinput(t)
end

function mainMenu:keypressed(key)
    suit.keypressed(key)
end

return mainMenu