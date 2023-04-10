require 'ruby2d'
require 'socket'
require 'rubygems'
exit if Object.const_defined?(:Ocra)

set background: 'navy'
set title: "Jogo da Cobravia"
set fps_cap: 20

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

module GameEntities
class Snake
  attr_writer :direction

  def initialize
    @positions = [[2,0],[2,1],[2,2],[2,3]]
    @direction = 'down'
    @growing = false
  end

  def desenhar
    # Desenha um quadrado para cada posição da cobra
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'gray')
    end
  end

  def grow
    # Define que a cobra deve crescer no próximo movimento
    @growing = true
  end

  def mover
    if !@growing
      # Remove a posição da cauda da cobra, caso ela não esteja crescendo
      @positions.shift
    end

    # Adiciona uma nova posição à cabeça da cobra, dependendo da direção atual
    @positions.push(next_position)
    @growing = false
  end

  def changeDirection?(new_direction)
    # Verifica se a nova direção é oposta à direção atual
    case @direction
    when 'up' then new_direction != 'down'
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def next_position
    # Retorna a próxima posição da cobra, dependendo da direção atual
    case @direction
    when 'down'
      new_cords(head[0], head[1] + 1)
    when 'up'
      new_cords(head[0], head[1] - 1)
    when 'left'
      new_cords(head[0] - 1, head[1])
    when 'right'
      new_cords(head[0] + 1, head[1])
    end
  end

  def hit_self?
    # Verifica se há posições duplicadas na cobra, indicando que ela colidiu com o próprio corpo
    @positions.uniq.length != @positions.length
  end

  private

  def new_cords(x, y)
    # Retorna as coordenadas (x, y) ajustadas para o tamanho da grade
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    # Retorna a posição da cabeça da cobra
    @positions.last
  end
end

class Game
  def initialize
    @score = 0
    @apple_x, @apple_y = rand(GRID_WIDTH), rand(GRID_HEIGHT)
    @finished = false
  end

  def draw
    Square.new(x: @apple_x * GRID_SIZE, y: @apple_y * GRID_SIZE, size: GRID_SIZE, color: 'red')
    Text.new("Pontuação: #{@score}", color:'green', x: 10, y: 10, size: 17.5)
  end

  def snake_hit_apple?(x, y)
    @apple_x == x && @apple_y == y
  end

  def record_hit
    @score += 1
    @apple_x = rand(GRID_WIDTH)
    @apple_y = rand(GRID_HEIGHT)
  end

  def finish
    puts "Game over"
    @finished = true
  end

  def finished?
    @finished
  end
end

snake = Snake.new
game = Game.new

update do
  clear

  unless game.finished?
    snake.mover
  end

  snake.desenhar
  game.draw

  if game.snake_hit_apple?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_self?
    game.finish
  end

  if snake.x < 0 || snake.x >= GRID_WIDTH || snake.y < 0 || snake.y >= GRID_HEIGHT
    game.finish
  end
end

on :key_down do |event|
    if['up', 'down', 'left', 'right'].include?(event.key)
     if snake.changeDirection?(event.key)
          snake.direction = event.key
     end
    end

    if game.finished? && event.key == 'r'
      snake = Snake.new
      game = Game.new
    end
  end

show

