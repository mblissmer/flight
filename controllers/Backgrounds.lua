local BgTemplate = require 'templates.background'
local Class = require 'libs.hump.class'

local Backgrounds = Class{
}

function Backgrounds:init(ul)
  self.backgroundList = {}
  local bg1 = BgTemplate(require('entities.bgFar'))
  local bg2 = BgTemplate(require('entities.bgNear'))
  ul:add(bg1,1)
  ul:add(bg2,1)
end

return Backgrounds