local o = {}

o.w=128
o.h=128
o.x = screenWidth - 100
--o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=0.2
o.scaleY=0.2
o.centerX = o.w / 2
o.centerY = o.h / 2
o.physScale = 0.1
o.speedX=screenWidth * 0.2
o.speedY=screenHeight * 0.1
o.yLimit=25
o.animTable={{0,1527},{132,1527},{264,1527},{396,1527}}
o.animSpeed=8
o.rotSpeed = 1
o.name="pickup1"
return o