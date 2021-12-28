Enemy = Class:extend()
Enemy:implement(Physics)
enemy_s = love.audio.newSource('assets/enemyDeath.ogg', 'static')
function Enemy:new(group, x , y)
   self.image = love.graphics.newImage('assets/player.png')
   self.class = 'Enemy'
   self.group = group
   self.group:add(self)
   self.timer = Timer()
   self.x, self.y = x, y
   self.r = 0
   self.tick = 0
   self.giragiragira = love.math.random(1, 30)/100
   self.z = 3
   self.tick_color = 0
   self.tick_death = 0
   self.ox, self.oy = 2, 0
   self.health = 3
   self.width, self.height = 8, 12

   self.enemy_filter = function(item, other)
      if other.class == 'Crate' then
         return nil
      else
         return 'slide'
      end
   end

   self.images = {
      idle = love.graphics.newImage('assets/enemy.png'),
      run = love.graphics.newImage('assets/enemyRun.png'),
   }

   self.animations = self:load_animations()

   self.x_vel, self.y_vel = utils.random_dir_int() * 100, 0
   self:create_body(8, 12)
   set_filters(self.images)
end

function Enemy:load_animations()
   local anims = {}
   anims.run_right = anim8.newAnimation(anim8.newGrid(12, 14, 60, 14)('1-5', 1), .07)
   anims.run_left = anims.run_right:clone():flipH()
   anims.idle_right = anim8.newAnimation(anim8.newGrid(12, 14, self.images.idle:getWidth(), self.images.idle:getHeight())('1-1', 1), .07)
   anims.idle_left = anims.idle_right:clone():flipH()
   return anims
end


function Enemy:update(dt)
   self.timer:update(dt)

   for _, animation in pairs(self.animations) do
      animation:update(dt)
   end

   if self.dead and self.tick_death > 0 then
      self.r = self.r - self.giragiragira * dt * 100
      self.tick_death = self.tick_death - dt
      self.x = self.x + self.x_vel * dt
      self.y = self.y + self.y_vel * dt
      self.y_vel = self.y_vel + 1200 * dt

   elseif not self.dead then
      self:apply_gravity(dt)
      self:move_and_slide(self.x_vel, self.y_vel, dt, self.enemy_filter)
   end
end

function Enemy:check_collisions(cols)
   for _, col in pairs(cols) do

      if col.normal.y < 0 then
         self.y_vel = 0
         self.is_grounded = true
      end
      if col.normal.y > 0 then
         self.y_vel = 0
      end

      if col.other.class == 'Player' then col.other.remove = true main:goto('MainMenu') end

      if col.other.class == 'Bullet' then return end
      if col.normal.x > 0 or col.normal.x < 0 then
         self.x_vel = -self.x_vel
      end
   end
   self.is_grounded = false
end

function Enemy:draw()

   if self.tick > 0 then
      love.graphics.setColor(1, self.tick_color, self.tick_color)
   end

   if self.x_vel > 0 then
      self.animations.run_right:draw(self.images.run, self.x, self.y, self.r, 1, 1, self.ox, self.oy)
   elseif self.x_vel <0 then
      self.animations.run_left:draw(self.images.run, self.x, self.y, self.r, 1, 1, self.ox, self.oy)
   else
      self.animations.idle_left:draw(self.images.idle, self.x, self.y, self.r, 1, 1, self.ox, self.oy)
   end
   love.graphics.setColor(1, 1, 1)
end

function Enemy:take_damage(damage, killer)
   self.health = self.health - damage
   self.tick = 1
   self.tick_color = 0
   self.timer:tween(.2, self, {tick_color = 1}, 'in-cubic')
   if self.health < 1 then self:die(killer) end
end

function Enemy:die(killer)
   self.tick_death = 1
   self.dead = true
   self.y_vel = -90
   self.ox, self.oy = 6, 7
   self.z = -1
   enemy_s:stop()
   enemy_s:play()
   local dir = self.x - killer.x
   self.x_vel = (dir > 0 and 1 or -1) * 100
   main.current.world:remove(self)
   self.timer:after(1, function() self.removed = true end)
end

Crate = Class:extend()
Crate:implement(Physics)
local pickup_s = love.audio.newSource('assets/pickup.ogg', 'static')
function Crate:new(group, last)
   local spawnpoint = require('levels/level1')
   local spawnable = spawnpoint.layers[3]
   self.index = love.math.random(1, #spawnable.objects)
   if self.index == last then Crate(group, last) return end
   local obj_to_spawn = spawnable.objects[self.index]

   self.x, self.y = love.math.random(obj_to_spawn.x + 8, obj_to_spawn.x + obj_to_spawn.width - 8), obj_to_spawn.y + obj_to_spawn.height - 8
   self.image = love.graphics.newImage('assets/box.png')
   self.class = 'Crate'
   self.group = group
   self.z = 2
   self.group:add(self)
   self.width, self.height = 8, 8
   self:create_body(8, 8)
end

function Crate:update(dt)

end

function Crate:pickup()
   Crate(main.current.main, self.index)
   main.current.player:get_random_weapon()



   for i = 1, 4 do
      CrateParticle(main.current.main, self.x, self.y - 6)
   end
   main.current.score = main.current.score + 1
   self.remove = true
   main.current.world:remove(self)
   pickup_s:stop()
   pickup_s:play()
end

function Crate:draw()

   love.graphics.draw(self.image, self.x, self.y)
end
