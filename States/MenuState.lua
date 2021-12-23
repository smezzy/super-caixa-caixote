MenuState = Class:extend()
MenuState:implement(State)

function MenuState:new(name)
   self:init_state(name)
   self.timer = Timer()
   self.spawn_timer = 0
   self.x = 0
   self.y  = 0
   self.score = 0
   self.persistent_draw = false
   self.persistent_update = false
end


function MenuState:on_enter(from)
   self.x = 90
   main:add(PlayState('Level1'))
end

function MenuState:update(dt)
   if self.timer then self.timer:update(dt) end
   if input:pressed('next') then
      main:goto('Level1')
   end
   self.t = love.timer.getTime()
   self.x = math.sin(self.t) * 12
   self.y = math.cos(self.t) * 12
   self.r = math.sin(self.t) / math.pi * .2
end

function MenuState:draw()

   local game_title = "GAME OVER"
   local play_text = "Aperta -> k <- pra joga!"
   local gtw = primary_font:getWidth(game_title)
   local ptw = secondary_font:getWidth(play_text)
   local gth = primary_font:getHeight(game_title)
   local pth = secondary_font:getHeight(play_text)

   local mid_x, mid_y = screen_width / 2, screen_height / 2

   love.graphics.setFont(primary_font)

   --main outline
   love.graphics.setColor(0, 0, 0)
   love.graphics.print(game_title, mid_x - 1 + self.x, mid_y - 15 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(game_title, mid_x + 1 + self.x, mid_y - 15 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(game_title, mid_x + self.x, mid_y- 15 - 1 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(game_title, mid_x + self.x, mid_y- 15 + 1 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)
   love.graphics.print(game_title, mid_x + self.x, mid_y- 15 + 2 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)

   love.graphics.setColor(237/255, 237/255, 237/255, 1)
   love.graphics.print(game_title, mid_x + self.x, mid_y - 15 + self.y, self.r, 1/pixel_size, 1/pixel_size, gtw/2, gth)


   love.graphics.setFont(secondary_font)
   --play outline
   love.graphics.setColor(0, 0, 0)
   love.graphics.print(play_text, mid_x - 1 + self.x, mid_y + 25+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)
   love.graphics.print(play_text, mid_x + 1 + self.x, mid_y + 25+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)
   love.graphics.print(play_text, mid_x + self.x, mid_y + 25 - 1+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)
   love.graphics.print(play_text, mid_x + self.x, mid_y + 25 + 1+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)
   love.graphics.print(play_text, mid_x + self.x, mid_y + 25 + 2+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)


   love.graphics.setColor(237/255, 237/255, 237/255, 1)
   love.graphics.print(play_text, mid_x + self.x, mid_y + 25+ self.y, self.r, 1/pixel_size, 1/pixel_size, ptw/2, 0)
   love.graphics.setColor(1, 1, 1, 1)

   love.graphics.setFont(primary_font)
end
