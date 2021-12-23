Class = require 'libraries/externs/classic'
Input = require 'libraries/externs/Input'
Camera = require 'libraries/externs/camera'
fn = require 'libraries/externs/moses'
Timer = require 'libraries/externs/timer'
utils = require 'libraries/utils'
vector2 = require 'libraries/vector2'
bump = require 'libraries/externs/bump'
lume = require 'libraries/lume'
sti = require 'libraries/externs/sti'
anim8 = require 'libraries/externs/anim8'
push = require 'libraries/externs/push'
--fonts
primary_font = love.graphics.newFont('fonts/FutilePro.ttf', 96)
secondary_font = love.graphics.newFont('fonts/MatchupPro.ttf', 64)
primary_font:setFilter('nearest', 'nearest')
secondary_font:setFilter('nearest', 'nearest')
