
Gamestate = require 'libs.hump.gamestate'

-- Game States
--local mainMenu = require 'gamestates.mainmenu'
local gameLevel1 = require 'gamestates.gameLevel1'
local pause = require 'gamestates.pause'

function love.load(arg)
  --Debugging
  if arg[#arg] == "-debug" then require("mobdebug").start() end


  spritesheet = love.graphics.newImage("assets/sheet.png")
  sheetWidth = spritesheet:getWidth()
  sheetHeight = spritesheet:getHeight()
  screenHeight = love.graphics.getHeight()
  Gamestate.registerEvents()
  Gamestate.switch(gameLevel1)
  testnumber1 = sign(12)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
--  if key == "m" then
--  	if Gamestate.current() == mainMenu then
--  		Gamestate.switch(gameLevel1)
--  	else
--  		Gamestate.switch(mainMenu)
--  	end
--  end
  if key == "p" and Gamestate.current() ~= pause then
  	Gamestate.push(pause)
  end
end