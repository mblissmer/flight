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
  local frame_width = 87
  local frame_height = 72
  xOriginOffset = frame_width / 2
  yOriginOffset = frame_height / 2
  table.insert(playerImage, love.graphics.newQuad(330, 1371, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(222, 1562, frame_width, frame_height, sheetWidth, sheetHeight))
  table.insert(playerImage, love.graphics.newQuad(372, 1132, frame_width, frame_height, sheetWidth, sheetHeight))
  
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