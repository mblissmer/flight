local e = {}

e.w=88
e.h=73
e.x=screenWidth + (e.w * 2)
e.y={e.h,screenHeight - 100}
e.scaleX=-0.5
e.scaleY=0.5
e.speedX=250
e.speedY=5
e.yLimit=50
e.animTable={{216,1878},{372,1059},{372,986},{372,1059}}
e.animSpeed=10
e.name="redPlane"
return e