local p = {}

p.w=121
p.h=62
p.x=100 
p.y=50
p.quadX=672
p.quadY=0
p.scaleX=0.5
p.scaleY=0.5
p.maxRot=0.2
p.rotSpeed=5
p.rotTolerance=0.1
p.physScale = 1
p.moveSpeed=300
p.name="player"

p.anims = {}

p.anims[1] = {}
p.anims[1]["frames"] = {}
local flameAnim = require 'animations.flame'
for i=1,table.getn(flameAnim.animTable) do
  local qx = flameAnim.animTable[i][1]
  local qy = flameAnim.animTable[i][2]
  table.insert(p.anims[1]["frames"], love.graphics.newQuad(qx, qy, flameAnim.w, flameAnim.h, sheetWidth, sheetHeight))
end
p.anims[1]["posX"] = -27
p.anims[1]["posY"] = 0
p.anims[1]["centerX"] = flameAnim.centerX
p.anims[1]["centerY"] = flameAnim.centerY
p.anims[1]["currentFrame"] = 1
p.anims[1]["rot"] = 0
p.anims[1]["scale"] = 0.06
p.anims[1]["speed"] = flameAnim.animSpeed
--o.anims[1]["draw"] = function()
--  love.graphics.draw(spritesheet, o.anims[1]["frames"][math.floor(o.anims[1]["currentFrame"])], o.anims[1]["x"], o.anims[1]["y"], o.anims[1]["rot"], o.anims[1]["scale"], o.anims[1]["scale"], o.anims[1]["centerX"], o.anims[1]["centerY"]) 
--end

--o.anims["move"] = function(x,y,dt)
--  for i=1, table.getn(o.anims) do
--    o.anims[i]["x"] = x + o.anims[i]["posX"]
--    o.anims[i]["y"] = y + o.anims[i]["posY"]
--    o.anims[i]["currentFrame"] = o.anims[i]["currentFrame"] + o.anims[i]["speed"] * dt
--    if o.anims[i]["currentFrame"] >= table.getn(o.anims[i]["frames"]) then
--      o.anims[i]["currentFrame"] = 1
--      end
--  end
--end



return p