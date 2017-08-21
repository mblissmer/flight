
-- Represents a collection of drawable entities.  Each gamestate holds one of these.

local Particles = {
  active = true,
  particleList = {}
}

function Particles:enter()
  self:clear()
end

function Particles:add(particle)
  table.insert(self.particleList, particle)
end

function Particles:addMany(particles)
  for k, particle in pairs(particles) do
    table.insert(self.particleList, particle)
  end
end

function Particles:remove(particle)
  for i, p in ipairs(self.particleList) do
    if p == particle then
      table.remove(self.particleList, i)
      return
    end
  end
end

function Particles:removeAt(index)
  table.remove(self.particleList, index)
end

function Particles:clear()
  self.particleList = {}
end

function Particles:draw()
  for i, p in ipairs(self.particleList) do
    p:draw(i)
  end
end

function Particles:update(dt)
  for i, e in ipairs(self.particleList) do
    e:update(dt, i)
  end
end

return Particles
