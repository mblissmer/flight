require 'libs.gooi'

local mainMenu = {}

local input = {text = ""}
local playerImage = {}
local animationSpeed = 8
local currentFrame = 1
local playerScale = 0.5
local xOriginOffset
local yOriginOffset
local newGameBtn
local exitBtn


function mainMenu:enter()
  -- Create player sprite
  playerImage = {}
  local pTable = require 'entities.player'
  for i=1,table.getn(pTable.animTable) do
    local qx = pTable.animTable[i][1]
    local qy = pTable.animTable[i][2]
    table.insert(playerImage, love.graphics.newQuad(qx, qy, pTable.w, pTable.h, sheetWidth, sheetHeight))
  end
  xOriginOffset = pTable.w/2
  yOriginOffset = pTable.h/2
  
   gooi.newLabel({
    text = "Plane Game",
    x=0,
    y=150,
    w = screenWidth,
    h = 25
}):center()
  newGameBtn = gooi.newButton({
      text="New Game",
      x = 200-50,
      y = screenHeight/2,
      w = 100,
      h = 25}):onRelease(function()
      switchGamestates("gameLevel1")
    end)
    :success()
  exitBtn = gooi.newButton({
      text = "Exit",
      x = screenWidth-200-50,
      y = screenHeight/2,
      w = 100,
      h = 25
  }):onRelease(function()
      gooi.confirm({
          text = "Are you sure?",
          ok = function()
              love.event.quit()
          end
      })
  end)
  :warning()
  
    newGameBtnSlider = gooi.newSlider({
    value = 0.75,
    x = 200-50,
    y = screenHeight/2 + 50,
    w = 100,
    h = 25
})
    exitBtnSlider = gooi.newSlider({
    value = 0.3,
    x = screenWidth-200-50,
    y = screenHeight/2 + 50,
    w = 100,
    h = 25
})
  
end

function mainMenu:leave()
  gooi.components = {}
end


function mainMenu:update(dt)
  gooi.update(dt)
  exitBtn.style.bgColor[2] = exitBtnSlider:getValue() * 255
  newGameBtn.style.bgColor[2] = newGameBtnSlider:getValue() * 255

  currentFrame = currentFrame + animationSpeed * dt
  if currentFrame >= table.getn(playerImage)+1 then
    currentFrame = 1
  end
end

function mainMenu:draw()
  
  gooi.draw()
  love.graphics.draw(spritesheet, playerImage[math.floor(currentFrame)], screenWidth/2, screenHeight/2, 0, playerScale, playerScale, xOriginOffset, yOriginOffset)
end
function love.mousepressed(x, y, button)  gooi.pressed() end
function love.mousereleased(x, y, button) gooi.released() end


return mainMenu