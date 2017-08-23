local Objects = {
  active = true,
  updateList = {}
}

function Objects:enter()
  self.updateList = {}
end

function Objects:add(object)
  table.insert(self.updateList, object)
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

function Objects:removeAt(index)
  table.remove(self.updateList, index)
end

function Objects:draw()
  for i, o in ipairs(self.updateList) do
    o:draw(i)
  end
end

function Objects:update(dt)
  for i, o in ipairs(self.updateList) do
    o:update(dt, i)
  end
end

return Objects
