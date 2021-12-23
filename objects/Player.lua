Player = Class:extend()
Player:implement(Physics)

function Player:new(group, x, y)
   self.class = 'Player'
   self.group = group
   self.group:add(self)
   self.id = utils.UUID()
   self.x, self.y = x or 0, y or 0
   self.r = 0
   self.z = 3
   self.sx, self.sy = 1, 1
   self.timer = Timer()
   self.remove = false
   self.deactivated = false
   self.width, self.height = 8, 12
   self.x_vel, self.y_vel = 0, 0
   self.ghost_timer = 0
   self.can_move = true
   self.fire_timer = 0
   self.weapons = {
      {
         name = 'pistol',
         image = love.graphics.newImage('assets/gun.png'),
         fire_mode = 'semi',
         fire_rate  = .1,
         damage  = 3,
         recoil = 200,
         index = 1,
         shoot = function(self)
            this = self.weapons[1]
            if self.fire_timer < self.current_weapon.fire_rate then return end
            self.fire_timer = 0
            camera:shake(2, .2, 55)
            self:apply_knockback(this.recoil)
            love.audio.newSource('assets/shot.ogg', 'static'):play()
            for i = 1, 6 do
               JumpParticle(main.current.main, self.x + self.width + 2, self.y + self.height - 2, love.math.random(19, 30))
            end
            Bullet(main.current.main, self.x, self.y + self.height/2, -utils.bool_to_int(self.flip_x), 0, this.damage, 470)
         end,
      },
      {
         name = 'smg',
         image = love.graphics.newImage('assets/smg.png'),
         fire_mode = 'automatic',
         fire_rate  = .08,
         damage  = 1,
         recoil = 100,
         index = 2,
         shoot = function(self)
            this = self.weapons[2]
            if self.fire_timer < self.current_weapon.fire_rate then return end
            self.fire_timer = 0
            camera:shake(2, .15, 70)
            self:apply_knockback(this.recoil)
            love.audio.newSource('assets/shot.ogg', 'static'):play()

            Bullet(main.current.main, self.x, self.y + self.height/2, -utils.bool_to_int(self.flip_x), 0, this.damage, 400)
         end,
      },
      {
         name = 'shotgun',
         image = love.graphics.newImage('assets/shotgun.png'),
         fire_mode = 'semi',
         fire_rate  = .4,
         damage  = 12,
         recoil = 600,
         bullet_speed = 300,
         shoot = function(self)
            this = self.weapons[3]
            if self.fire_timer < self.current_weapon.fire_rate then return end
            self.fire_timer = 0
            camera:shake(2, .2, 55)
            love.audio.newSource('assets/shot.ogg', 'static'):play()
            self:apply_knockback(this.recoil)

                        for i = 1, 5 do
                           Bullet(main.current.main, self.x, self.y + self.height/2, -utils.bool_to_int(self.flip_x), utils.random_dir() * 50, this.damage, love.math.random(200, this.bullet_speed))
                        end
         end,
      },
      {
         name = 'dual_pistol',
         image = love.graphics.newImage('assets/gun.png'),
         fire_mode = 'semi',
         fire_rate  = .1,
         damage  = 2,
         recoil = 200,
         bullet_speed = 400,
         shoot = function(self)
            this = self.weapons[4]
            if self.fire_timer < self.current_weapon.fire_rate then return end
            self.fire_timer = 0
            camera:shake(2, .2, 55)
            love.audio.newSource('assets/shot.ogg', 'static'):play()

            Bullet(main.current.main, self.x, self.y + self.height/2, -utils.bool_to_int(self.flip_x), 0, this.damage, this.bullet_speed)
            Bullet(main.current.main, self.x, self.y + self.height/2, utils.bool_to_int(self.flip_x), 0, this.damage, this.bullet_speed)

         end,
      },

   }

   self.current_weapon = self.weapons[1]

   self.dust_t = 0
   self.gun = {
      image = love.graphics.newImage('assets/gun.png'),
      x = self.x + 8,
      y = self.y + self.height/2,
   }

   self.images = {
      idle = love.graphics.newImage('assets/player.png'),
      run = love.graphics.newImage('assets/playerRun.png'),
      jump = love.graphics.newImage('assets/playerJump.png'),
      ghost = love.graphics.newImage('assets/player.png'),
   }

   self.player_filter = function(item, other)
      if other.class == 'Bullet' then
         return nil
      elseif other.class == 'Crate' then
         return 'cross'
      else
         return 'slide'
      end
   end

   self.animations = self:load_animations()
   self.flip_x = false

   set_filters(self.images)
   set_filters(self.gun.image)

   self:create_body(self.width, self.height)

   for _, obj in ipairs(self.weapons) do
      set_filters(obj.image)
   end

   return self


end

function Player:load_animations()
   local anims = {}
   anims.run_right = anim8.newAnimation(anim8.newGrid(12, 14, 60, 14)('1-5', 1), .07)
   anims.run_left = anims.run_right:clone():flipH()
   anims.idle_right = anim8.newAnimation(anim8.newGrid(12, 14, self.images.idle:getWidth(), self.images.idle:getHeight())('1-1', 1), .07)
   anims.idle_left = anims.idle_right:clone():flipH()
   anims.jump_right = anim8.newAnimation(anim8.newGrid(12, 14, self.images.jump:getWidth(), self.images.jump:getHeight())('1-4', 1), .05)
   anims.jump_left = anims.jump_right:clone():flipH()
   return anims
end

function set_filters(images)

   if type(images) == 'table' then
      for _, image in pairs(images) do
         image:setFilter('nearest', 'nearest')
      end
      return
   end
   images:setFilter('nearest', 'nearest')

end
local dir = 1
function Player:update(dt)
   if self.y > 350 then main:goto('MainMenu')  end
   self.timer:update(dt)
   self.fire_timer =  self.fire_timer + dt
   if self.is_grounded and self.x_vel > 0 or self.x_vel < 0 then self.dust_t = self.dust_t + dt else self.dust_t = 0 end
   if self.dust_t > .3 then
      self.dust_t = 0
      for i = 1, 2 do
         JumpParticle(main.current.main, self.x + self.width/2, self.y + self.height - 2, love.math.random(-self.x_vel/4, -self.x_vel/2))
      end
   end

   for _, animation in pairs(self.animations) do
      animation:update(dt)
   end

   self:apply_gravity(dt)

   if self.can_move and input:down('left') then
      self.flip_x = true
      dir = -1
      self.x_vel = self.x_vel + 50
      self.x_vel = self.x_vel * math.pow(.3, dt * 10)
   elseif self.can_move and input:down('right') then
      self.flip_x = false
      self.x_vel = self.x_vel + 50
      self.x_vel = self.x_vel * math.pow(.3, dt * 10)
      dir = 1
   else
      self.x_vel = self.x_vel * math.pow(.1, dt * 10)
   end

   if math.abs(self.x_vel) < 10 then
      self.x_vel = 0
   end
   if self.x_vel > 150 then
       self.x_vel = 150
   end
   if self.current_weapon.fire_mode == 'automatic' then
      if input:down('shoot') then
         self.current_weapon.shoot(self)
      end
   else
      if input:pressed('shoot') then
         self.current_weapon.shoot(self)
      end
   end


   if input:pressed('up') and self.is_grounded and not self.is_jumping then
      self.y_vel = -320
      self.is_jumping = true
      self.is_grounded = false
      for i = 1, 4 do
         JumpParticle(main.current.main, self.x + self.width/2, self.y + self.height - 2)
      end
   end
   if input:released('up') and self.y_vel < 0 then
      self.y_vel = 0
   end

   self:move_and_slide(self.x_vel * dir, self.y_vel, dt, self.player_filter)
   self.gun.x, self.gun.y = self.x + self.width/2  + utils.bool_to_int(self.flip_x) * -4, self.y + 4
end

function Player:apply_knockback(recoil)
   self.can_move = false
   self.x_vel = -recoil
   self.timer:after(.05, function() self.can_move = true end)
end



function Player:draw()

   if self.is_jumping and self.flip_x then
      self.animations.jump_left:draw(self.images.jump, self.x, self.y, 0, 1, 1, 2, 0)
   elseif self.is_jumping then
      self.animations.jump_right:draw(self.images.jump, self.x, self.y, 0, 1, 1, 2, 0)
   elseif self.x_vel > 0  or self.x_vel < 0 then
      if self.flip_x then
         self.animations.run_left:draw(self.images.run, self.x, self.y, 0, 1, 1, 2, 0)
      else
         self.animations.run_right:draw(self.images.run, self.x, self.y, 0, 1, 1, 2, 0)
      end
   else
      if self.flip_x then
         self.animations.idle_left:draw(self.images.idle, self.x, self.y, 0, 1, 1, 2, 0)
      else
         self.animations.idle_right:draw(self.images.idle, self.x, self.y, 0, 1, 1, 2, 0)
      end
   end

   if self.flip_x then
      if self.current_weapon.name == 'dual_pistol' then
         --please remove tommmorrow
         love.graphics.draw(self.current_weapon.image, self.gun.x, self.gun.y, 0, -1, 1 )
         love.graphics.draw(self.current_weapon.image, self.gun.x + self.width, self.gun.y)
         return
      end
      love.graphics.draw(self.current_weapon.image, self.gun.x, self.gun.y, 0, -1, 1 )
   else
      if self.current_weapon.name == 'dual_pistol' then
         --please remove tommmorrow
         love.graphics.draw(self.current_weapon.image, self.gun.x - self.width, self.gun.y, 0, -1, 1 )
         love.graphics.draw(self.current_weapon.image, self.gun.x, self.gun.y)
         return
      end
      love.graphics.draw(self.current_weapon.image, self.gun.x, self.gun.y)
   end
   -- main.current.map:bump_draw()

end

function Player:check_collisions(cols)
   for _, col in pairs(cols) do
      if col.other.class == 'Crate' then
         col.other:pickup()
      end
      if col.other.class == 'Enemy' then main:goto('MainMenu') end

      if col.normal.y < 0 then
         self.y_vel = 0
         self.is_jumping = false
         if not self.is_grounded then
            for i = 1, 3 do
               JumpParticle(main.current.main, self.x + self.width/2, self.y + self.height - 2)
            end
         end
         self.is_grounded = true
      end
      if col.normal.y > 0 then
         self.y_vel = 0
      end
      return
   end
   self.is_grounded = false
end

function Player:get_random_weapon()
   local rnd_weapon = self.weapons[love.math.random(1, #self.weapons)]
   if self.current_weapon.name == rnd_weapon.name then self:get_random_weapon() return end
   self.current_weapon = rnd_weapon
end

Bullet = Class:extend()
Bullet:implement(Physics)

function Bullet:new(group, x, y, xvel, yvel, damage, bullet_speed)
   if not group then return end
   self.class = 'Bullet'
   self.timer = Timer()
   self.width, self.height = 4, 4
   self.x, self.y = x, y
   self.z = 2
   self.group = group
   self.group:add(self)
   self.damage = damage
   self.image = love.graphics.newImage('assets/bullet.png')
   self.spd = bullet_speed
   self.x_vel, self.y_vel = xvel, yvel
   self.bullet_filter = function(item, other)
      if other.class == 'Player' then
         return nil
      elseif other.class == 'Crate' then
         return nil
      elseif other.class == 'Bullet' then
         return nil
      else
         return 'slide'
      end

   end
   set_filters(self.image)
   self:create_body(self.width, self.height)
end

function Bullet:update(dt)
   self.timer:update(dt)
   self:move_and_slide(self.x_vel * self.spd, self.y_vel, dt, self.bullet_filter)
end

function Bullet:draw()
   love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, 6, 6)
end

function Bullet:on_collision_enter(cols)
   for _, col in pairs(cols) do
      if col.other.class == 'Enemy' then col.other:take_damage(self.damage, self) end
   end
   self:destroy()
end

function Bullet:destroy()
   self.remove = true
   main.current.world:remove(self)
end
