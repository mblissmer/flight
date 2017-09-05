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
o.speedX=screenWidth * 0.2 --previously 250
o.speedY=5
o.yLimit=50
o.animTable={{891,1340},{1054,1340},{1217,1340},{1054,1340}}
o.animSpeed=10
o.name="redShip"
return o