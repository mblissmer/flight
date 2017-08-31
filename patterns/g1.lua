local file = io.open("patterns/g1.pattern")
local p = {}
local i = 0
if file then
  for line in file:lines() do
    i = i + 1
    p[i] = {}
    for k, v in string.gmatch(line, "(%w+)=(%w+)") do
      p[i][k] = tonumber(v)
    end
  end
  file:close()
else 
  print "no file!"
end
return p
