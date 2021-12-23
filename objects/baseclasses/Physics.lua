Physics = Class:extend()

function Physics:create_body(w, h)
   main.current.world:add(self, self.x, self.y, w, h)
end

function Physics:move_and_slide(dirx, diry, dt, filter)
   if not main.current.world then return end
   local actual_x, actual_y, cols, len = main.current.world:move(self, self.x + dirx * dt, self.y + diry * dt, filter)
   self.x, self.y = actual_x, actual_y
   if len > 0 then
      if self.on_collision_enter then self:on_collision_enter(cols) end
   end
   if self.check_collisions then self:check_collisions(cols) end
end
function Physics:apply_gravity(dt)

   self.y_vel = self.y_vel + 1200 * dt
end
