local o = {}

o.w=159
o.h=108
o.x = screenWidth - 100
--o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=0.5
o.scaleY=0.5
o.centerX = o.w / 2 - 20
o.centerY = o.h / 2
o.physScale = 0.15
o.speedX=screenWidth * 0.2
o.speedY=screenHeight * 0.1
o.yLimit=25
o.animTable={{0,1340},{163,1340},{326,1340},{163,1340}}
o.animSpeed=8
o.name="blueShip"
return o