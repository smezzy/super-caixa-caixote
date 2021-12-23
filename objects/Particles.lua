Template = Class:extend()

function Template:new()

end

function Template:update(dt)

end

function Template:draw()

end

JumpParticle = Class:extend()

function JumpParticle:new(group, x, y, xvel, yvel)
   if not group then return end 
   self.radius = love.math.random(1, 2)
   self.timer = Timer()
   self.group = group
   self.class = 'Particle'
   self.group:add(self)
   self.x = x
   self.y = y
   self.z = 2
   self.remove = false
   self.x_vel = xvel or love.math.random(50, 90) * love.math.random(-1, 1)
   self.y_vel = yvel or love.math.random(-2, -20)
   self.timer:tween(.4, self, { radius = 0}, 'in-cubic' )
   self.timer:tween(.6, self, { x_vel = 0}, 'out-quint' )

   self.timer:after(1, function() self.remove = true end)
end

function JumpParticle:update(dt)
   self.timer:update(dt)
   self.x, self.y = self.x + self.x_vel * dt, self.y + self.y_vel  * dt
end

function JumpParticle:draw()
   love.graphics.setColor(1, 1, 1, .8)
   love.graphics.circle('fill', self.x, self.y, self.radius)
   love.graphics.setColor(1, 1, 1)
end

CrateParticle = Class:extend()

function CrateParticle:new(group, x, y, xvel, yvel)
   self.timer = Timer()
   self.group = group
   self.class = 'Particle'
   self.group:add(self)
   self.x = x
   self.y = y
   self.z = 6
   self.color = 1
   self.remove = false
   self.height = 16
   self.width = 16
   self.alpha = 1
   self.color = 0
   self.text_height = 0
   self.timer:tween(.2, self, { height = 0, alpha = 0}, 'in-cubic' )

   self.timer:after(.05, function() self.color = 1 end)
   self.timer:after(1, function() self.remove = true end)
end

function CrateParticle:update(dt)
   self.timer:update(dt)
   -- self.y_vel = self.y_vel + 400 * dt
end

function CrateParticle:draw()
   local player = main.current.player
   local gtw = secondary_font:getWidth(player.current_weapon.name)
   local gth = secondary_font:getHeight(player.current_weapon.name)

   local x, y = self.x, self.y - 5 + self.text_height
   self.text_height = self.text_height - .2
   love.graphics.setFont(secondary_font)

   --main outline
   love.graphics.setColor(0, 0, 0)
   love.graphics.print(player.current_weapon.name, x - 1, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.name, x + 1, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.name, x, y - 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.name, x, y + 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.name, x, y + 2, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.setColor(1, 1, 1)

   love.graphics.print(player.current_weapon.name, x, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)

   love.graphics.setColor(self.color, self.color, self.color, self.alpha)
   love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
   love.graphics.setColor(1, 1, 1)
end

DamageParticle = Class:extend()

function DamageParticle:new(group, x, y, xvel, yvel)
   self.timer = Timer()
   self.group = group
   self.class = 'Particle'
   self.group:add(self)
   self.x = x
   self.y = y
   self.z = 6
   self.color = 1
   self.remove = false
   self.height = 16
   self.width = 16
   self.alpha = 1
   self.color = 0
   self.text_height = 5
   self.timer:tween(.2, self, { height = 0, alpha = 0}, 'in-cubic' )

   self.timer:after(.05, function() self.color = 1 end)
   self.timer:after(1, function() self.remove = true end)
end

function DamageParticle:update(dt)
   self.timer:update(dt)
   -- self.y_vel = self.y_vel + 400 * dt
end

function DamageParticle:draw()
   local player = main.current.player
   local gtw = secondary_font:getWidth(player.current_weapon.damage)
   local gth = secondary_font:getHeight(player.current_weapon.damage)

   local x, y = self.x, self.y+ self.text_height
   self.text_height = self.text_height - .2
   love.graphics.setFont(secondary_font)

   --main outline
   love.graphics.setColor(0, 0, 0)
   love.graphics.print(player.current_weapon.damage, x - 1, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.damage, x + 1, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.damage, x, y - 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.damage, x, y + 1, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(player.current_weapon.damage, x, y + 2, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.setColor(1, 1, 1)

   love.graphics.print(player.current_weapon.damage, x, y, 0, 1/pixel_size, 1/pixel_size, gtw/2, gth)

   love.graphics.setColor(self.color, self.color, self.color, self.alpha)
   love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
   love.graphics.setColor(1, 1, 1)
end



Ghost = Class:extend()

function Ghost:new(group, x, y, image, quad)
   self.group = group
   self.image = image
   self.quad = quad
   self.class = 'Particle'
   self.group:add(self)
   self.x = x
   self.y = y
   self.z = 0
   self.remove = false
   self.alpha = 1

end

function Ghost:update(dt)
   self.alpha = self.alpha - dt * 2
   if self.alpha == 0 then self.remove = true end
end

function Ghost:draw()
   love.graphics.setColor( 1, 1, 1, self.alpha)
   love.graphics.draw(self.image, self.quad, self.x, self.y)
   love.graphics.setColor( 1, 1, 1, 1)
end
