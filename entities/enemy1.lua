local o = {}

o.w=88
o.h=73
o.x = screenWidth - 100
--o.x=screenWidth + (o.w * 2)
o.y={o.h,screenHeight - 100}
o.scaleX=-0.5
o.scaleY=0.5
o.physScale = 0.15
o.speedX=screenWidth * 0.2
o.speedY=screenHeight * 0.1
o.yLimit=25
o.animTable={{304,1967},{330,1298},{330,1225},{330,1298}}
o.animSpeed=8
o.name="yellowPlane"
return o