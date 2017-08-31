local o = {}

o.w=39
o.h=37
o.x = screenWidth - 100
--o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=0.5
o.scaleY=0.5
o.physScale = 0.3
o.speedX=screenWidth * 0.2
o.speedY=screenHeight * 0.1
o.yLimit=25
o.animTable={{170,1996},{369,1444},{330,1444}}
o.animSpeed=8
o.rotSpeed = 1
o.name="pickup1"
return o