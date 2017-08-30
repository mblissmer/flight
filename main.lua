
Gamestate = require 'libs.hump.gamestate'

-- Game States
local mainMenu = require 'gamestates.mainMenu'
local gameLevel1 = require 'gamestates.gameLevel1'
local pause = require 'gamestates.pause'

function love.load(arg)
  --Debugging
  if arg[#arg] == "-debug" then require("mobdebug").start() end


  spritesheet = love.graphics.newImage("assets/sheet.png")
  sheetWidth = spritesheet:getWidth()
  sheetHeight = spritesheet:getHeight()
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  Gamestate.registerEvents()
  Gamestate.switch(mainMenu)
end

function switchGamestates(state)
  if state == "gameLevel1" then
    Gamestate.switch(gameLevel1)
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
  if key == "m" then
    Gamestate.switch(mainMenu)
  end
  if key == "p" and Gamestate.current() ~= pause then
  	Gamestate.push(pause)
  end
end