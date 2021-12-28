PlayState = Class:extend()
PlayState:implement(State)

local bg_particles = {}

function PlayState:new(name)
   self:init_state(name)
end

function PlayState:on_enter(from)
   self.exiting = false
   self.ost = love.audio.newSource('assets/ost.mp3', 'static')
   self.ost:setLooping(true)
   self.ost:play()
   self.timer = Timer()
   self.world = bump.newWorld()
   self.main = Group()
   self.GRAVITY_SCALE = 9
   self.map = sti('/levels/level1.lua', {'bump'})
   self.map:bump_init(self.world)
   self.player = nil
   self.persistent_draw = false
   self.persistent_update = false
   self.height = 0
   self.timer:every(2, function() Enemy(self.main, screen_width/2, 0)  end)
   self.timer:every(5, function() Enemy(self.main, screen_width/2, 0)  end)
   self.timer:every(8, function() Enemy(self.main, screen_width/2, 0)  end)
   self.timer:every(12, function() Enemy(self.main, screen_width/2, 0)  end)
   self.score = 1
   camera.x, camera.y = screen_width/2,screen_height/2
   self.timer:every(.13, function() table.insert(bg_particles, BackgroundParticles(self.main)) end)

   self.player = Player(self.main, screen_width/2, screen_height/2)
   Enemy(self.main, screen_width/2, 0)
   Crate(self.main, 0)
end

function PlayState:on_exit(from)
   self.ost:stop()
   self.ost = nil
   self.main = nil
   self.world = nil
   self.timer = nil
   self.map = nil
   return true
end

function PlayState:update(dt)

   if self.timer then self.timer:update(dt) end
   self.main:update(dt)
   self.height = self.height + dt * 10
   camera:update(dt)
   for i = #bg_particles, 1, -1 do
      bg_particles[i]:update(dt)
      if bg_particles[i].remove then
         table.remove(bg_particles, i)
      end
   end
end

function PlayState:draw()
   camera:attach()
   --background begin
   love.graphics.push()
   love.graphics.translate(camera.x, camera.y)

   --score  lmao this is so shit

   -- score end
   for _, particle in pairs(bg_particles) do
      particle:draw()
   end

   love.graphics.setColor(116/255, 191/255, 231/255)
   love.graphics.rotate(45* math.pi/180)
   for i = -16, 16 do
      love.graphics.rectangle('fill', -screen_width/2 - 30, screen_height/2 + (self.height + i * 50), 900, 25)
   end
   if self.height > screen_height then
      self.height = self.height - 25 * 12
   end

   love.graphics.setColor(1, 1, 1)
   love.graphics.pop()
   --background end


   local gtw = primary_font:getWidth(tostring(self.score))
   local gth = primary_font:getHeight(tostring(self.score))

   local mid_x, mid_y = screen_width / 2, screen_height / 2

   love.graphics.setFont(primary_font)

   --main outline
   love.graphics.setColor(0, 0, 0)
   love.graphics.print(tostring(self.score), mid_x - 1, 0 + 35, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(tostring(self.score), mid_x + 1, 0 + 35, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(tostring(self.score), mid_x, 0 + 35 - 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(tostring(self.score), mid_x, 0 + 35 + 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(tostring(self.score), mid_x, 0 + 35 + 2, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.setColor(1, 1, 1)

   love.graphics.print(tostring(self.score), mid_x, 0 + 35, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)

   self.map:drawLayer(self.map.layers["Camada de Tiles 1"])
   self.main:draw()
   camera:detach()

end

BackgroundParticles = Class:extend()
function BackgroundParticles:new()
   self.radius = love.math.random(5, 15)
   self.x, self.y = love.math.random(-screen_width/2 - 50, screen_width + 50), screen_height/2
   self.speed = love.math.random(10, 50)
   self.range = love.math.random(8, 20)
   self.t = 0
   return self
end

function BackgroundParticles:update(dt)
   if self.y < -500 then self.remove = true end
   self.y = self.y - self.speed * dt
   self.t = self.t + dt * love.math.random(1, 2)
   self.x = self.x + math.sin(self.t) * self.range * dt * 2
end

function BackgroundParticles:draw()
   love.graphics.setLineStyle('rough')
   love.graphics.setColor(116/255, 191/255, 231/255)
   if self.radius < 12 then
      love.graphics.circle('fill', self.x, self.y, self.radius)
   else
      love.graphics.rectangle('line', self.x, self.y, self.radius, self.radius)
   end
   love.graphics.setLineStyle('smooth')
end
