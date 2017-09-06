local o = {}

o.w=108
o.h=108
o.x = screenWidth - 100
--o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=0.5
o.scaleY=0.5
o.centerX = o.w / 2
o.centerY = o.h / 2
o.physScale = 0.15
o.speedX=screenWidth * 0.2 --previously 250
o.speedY=5
o.yLimit=50
o.animTable={{560,0},{448,0},{0,0},{448,0}}
o.animSpeed=10
o.name="redShip"

-- Animations
o.anims = {}

-- Animation 1
o.anims[1] = {}
o.anims[1]["frames"] = {}
local flameAnim = require 'animations.flame'
for i=1,table.getn(flameAnim.animTable) do
  local qx = flameAnim.animTable[i][1]
  local qy = flameAnim.animTable[i][2]
  table.insert(o.anims[1]["frames"], love.graphics.newQuad(qx, qy, flameAnim.w, flameAnim.h, sheetWidth, sheetHeight))
end
o.anims[1]["posX"] = -27
o.anims[1]["posY"] = 0
o.anims[1]["centerX"] = flameAnim.centerX
o.anims[1]["centerY"] = flameAnim.centerY
o.anims[1]["currentFrame"] = 1
o.anims[1]["rot"] = 0
o.anims[1]["scale"] = 0.06
o.anims[1]["speed"] = flameAnim.animSpeed
o.anims[1]["draw"] = function()
  love.graphics.draw(spritesheet, o.anims[1]["frames"][math.floor(o.anims[1]["currentFrame"])], o.anims[1]["x"], o.anims[1]["y"], o.anims[1]["rot"], o.anims[1]["scale"], o.anims[1]["scale"], o.anims[1]["centerX"], o.anims[1]["centerY"]) 
end

-- Animation 2
o.anims[2] = {}
o.anims[2]["frames"] = {}
local laserAnim = require 'animations.laserRed'
for i=1,table.getn(laserAnim.animTable) do
  local qx = laserAnim.animTable[i][1]
  local qy = laserAnim.animTable[i][2]
  table.insert(o.anims[2]["frames"], love.graphics.newQuad(qx, qy, laserAnim.w, laserAnim.h, sheetWidth, sheetHeight))
end
o.anims[2]["posX"] = -27
o.anims[2]["posY"] = 0
o.anims[2]["centerX"] = laserAnim.centerX
o.anims[2]["centerY"] = laserAnim.centerY
o.anims[2]["currentFrame"] = 1
o.anims[2]["rot"] = 0
o.anims[2]["scale"] = 0.06
o.anims[2]["speed"] = laserAnim.animSpeed
o.anims[2]["draw"] = function()
  love.graphics.draw(spritesheet, o.anims[2]["frames"][math.floor(o.anims[2]["currentFrame"])], o.anims[2]["x"], o.anims[2]["y"], o.anims[2]["rot"], o.anims[2]["scale"], o.anims[2]["scale"], o.anims[2]["centerX"], o.anims[2]["centerY"]) 
end


-- Move function for all anims
o.anims["move"] = function(x,y,dt)
  for i=1, table.getn(o.anims) do
    -- Relocate anims
    o.anims[i]["x"] = x + o.anims[i]["posX"]
    o.anims[i]["y"] = y + o.anims[i]["posY"]
    
    -- Update frame count
    o.anims[i]["currentFrame"] = o.anims[i]["currentFrame"] + o.anims[i]["speed"] * dt
    if o.anims[i]["currentFrame"] >= table.getn(o.anims[i]["frames"]) then
      o.anims[i]["currentFrame"] = 1
      end
  end
end

return o