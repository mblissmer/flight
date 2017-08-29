local BgTemplate = require 'templates.background'
local Class = require 'libs.hump.class'

local Backgrounds = Class{
}

function Backgrounds:init()
  self.backgroundList = {}
  local bg1 = BgTemplate(require('entities.bgFar'))
  local bg2 = BgTemplate(require('entities.bgNear'))
  UpdateList:add(bg1,1)
  UpdateList:add(bg2,1)
end

return Backgrounds