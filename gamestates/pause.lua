
pause = Gamestate.new()

function pause:enter(from)
  self.from = from -- record previous state
end

function pause:draw()
  -- draw previous screen
  self.from:draw()

  -- overlay with pause message
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('PAUSE', 0, screenHeight/2, screenWidth, 'center')
end

function pause:keypressed(key)
  if key == 'p' then
    return Gamestate.pop() -- return to previous state
  end
end

return pause
