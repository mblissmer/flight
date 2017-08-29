local o = {}

o.w=88
o.h=73
o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=-0.5
o.scaleY=0.5
o.physScale = 0.15
o.speedX=250
o.speedY=5
o.yLimit=50
o.animTable={{216,1878},{372,1059},{372,986},{372,1059}}
o.animSpeed=10
o.name="redPlane"
return o