Utils = {}

function Utils.UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end



-- love.math.random() only returns integers if arguments are specifeid
function Utils.random(min, max)
   if not max then
      return love.math.random()*min
   else
      if min > max then min, max = max, min end
      return love.math.random()*(max - min) + min
   end
end


function Utils.print_table(table)
   if not table then return 'Table is nil' end
   for k, v in pairs(table) do
      print(k, v)
   end
end


function Utils.sqr_distance(x1, y1, x2, y2)
   local dx = x1 - x2
   local dy = y1 - y2
   return dx*dx + dy*dy
end

function Utils.distance(x1, y1, x2, y2)
   local dx = x1 - x2
   local dy = y1 - y2
   return math.sqrt(dx*dx + dy*dy)
end

function Utils.copy_table(table)
   local out = {}
   for k, v in pairs(table) do
      out[k] = v
   end
   return out
end

function Utils.random_dir()
   return love.math.random() * love.math.random(-1, 1)
end

function Utils.random_dir_int()
   local rand = love.math.random(1, 51)
   if rand > 25 then return 1 else return -1 end
end

function Utils.sign(n)
   return n == 0 and 0 or math.abs(n)/n
end

function Utils.bool_to_int(bool)
   return bool and 1 or -1
end

function Utils.clamp_sign(num, max)
   if not max then return nil end
   print(num, max)
   if num > max then
      return max
   elseif num < -max then
      return -max
   end
   return num
end



return Utils
