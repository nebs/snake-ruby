require_relative 'grid2d'
require_relative 'snake'
require_relative 'game'

puts '~~~SNAKE~~~'
grid  = Grid2D.new(20,20)
snake = Snake.new(4,6,6)
game  = Game.new(grid, snake)
game.start
