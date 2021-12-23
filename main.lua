require 'requirements'

window_width = 1280
window_height = 720
pixel_size = 4
screen_width = 288 --288
screen_height = 192 --192
show_fps = true
local switch_vsync = 0
local fulscreen = false

love.graphics.setDefaultFilter("nearest", "nearest")
push:setupScreen(screen_width, screen_height, window_width, window_height, {fullscreen = false, resizable = true, pixelperfect = false, canvas = false})

function love.load()
   local base_classes = recursive_enumerate('objects/baseclasses')
   local object_files = recursive_enumerate('objects')
   local room_files = recursive_enumerate('States')
   -- require_files(base_classes)
   -- require_files(object_files)
   -- require_files(room_files)

   input = Input()
   camera = Camera(screen_width/pixel_size, screen_height/pixel_size, screen_width, screen_height)
   --main = main state which stores the other states
   main = Main()
   main:add(MenuState('MainMenu'))
   main:goto('MainMenu')
   main_canvas = love.graphics.newCanvas(288, 192)
   main_canvas:setFilter('nearest', 'nearest')

   input:bind('f', function()
	push:switchFullscreen()
   end)

   input:bind('g', function()
	love.window.setMode(1920,1080)
        push:resize(1920, 1080)
   end)

   push:setBorderColor(184/255, 220/255, 239/255)
   -- love.graphics.setBackgroundColor(7/255, 30/255, 52/255, 1)
   -- love.graphics.setBackgroundColor(60/255, 9/255, 45/255, 1)
   setup_input()
end

function love.resize(w, h)
   push:resize(w, h)
end

function setup_input()
   input:bind('a', 'left')
   input:bind('left', 'left')
   input:bind('d', 'right')
   input:bind('right', 'right')
   input:bind('w', 'up')
   input:bind('up', 'up')
   input:bind('z', 'up')
   input:bind('s', 'down')
   input:bind('down', 'down')
   input:bind('shoot', 'up')
   input:bind('x', 'shoot')
   input:bind('j', 'prev')
   input:bind('k', 'next')
   input:bind('f2', 'vsync')
   input:bind('c', 'dash')
end

function require_files(files)
   for _, file in ipairs(files) do
      local file = file:sub(1, -5)
      require(file)
   end
end

function recursive_enumerate(folder)
   local file_list = {}
   local items = love.filesystem.getDirectoryItems(folder)
   for _, item in  ipairs(items) do
      local file = folder .. '/' .. item
      if love.filesystem.getInfo(file).type == 'file' then
         table.insert(file_list, file)
      elseif love.filesystem.getInfo(file).type == 'directory' then
         recursive_enumerate(file, file_list)
      end
   end

   for _, file in ipairs(file_list) do
      local file = file:sub(1, -5)
      require(file)
   end

   -- return file_list
end

function love.update(dt)
   if input:pressed('vsync') then
      switch_vsync = switch_vsync == 1 and 0 or switch_vsync == 0 and 1
      love.window.setVSync(switch_vsync)
   end

   -- require('lurker').update()
   if main then main:update(dt) end


end

function love.draw()
   push:start()
   if main then main:draw() end
   push:finish()
   if show_fps then love.graphics.print(love.timer.getFPS(), 10, 10, 0, .5, .5) end

end
