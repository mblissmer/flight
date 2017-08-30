local Objects = {
  active = true,
--  updateList = {}
}

function Objects:enter()
  self.updateList = {}
  self.layers = 5
  for i=1,self.layers do
    table.insert(self.updateList, {})
  end
end

function Objects:add(object, layer)
  table.insert(self.updateList[layer], object)
end

function Objects:addMany(objects)
  for k, object in pairs(objects) do
    table.insert(self.updateList, object)
  end
end

function Objects:remove(object)
  for i, o in ipairs(self.updateList) do
    if o == object then
      table.remove(self.updateList, i)
      return
    end
  end
end

function Objects:removeAll()
  self.updateList = nil
end

function Objects:removeAt(index)
  table.remove(self.updateList, index)
end

function Objects:draw()
  for i, l in ipairs(self.updateList) do
    for n, o in ipairs(self.updateList[i]) do
      o:draw()
    end
  end
end

function Objects:update(dt)
  for i, l in ipairs(self.updateList) do
    for n, o in ipairs(self.updateList[i]) do
      o:update(dt)
    end
  end
end

return Objects
