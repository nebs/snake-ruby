class Game

  KEYBOARD_COMMANDS = {
    i: :up,
    k: :down,
    j: :left,
    l: :right,
    q: :quit
  }

  def initialize(grid, snake)
    @snake = snake
    @grid = grid
  end

  def key_for_action(action)
    KEYBOARD_COMMANDS.find { |k,v| v == action }.first
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def print_instructions
    puts "========================="
    puts "=== SNAKE ==============="
    puts "========================="

    puts ""
    KEYBOARD_COMMANDS.each do |key, value|
      puts "#{key.to_s} : #{ value.to_s.capitalize }"
    end
    puts ""
  end

  def start
    randomly_place_food

    while true
      clear_screen
      print_instructions

      # Get keyboard input
      system("stty raw -echo")
      key_pressed = STDIN.read_nonblock(1) rescue nil
      system("stty -raw echo")

      # Quit?
      break if key_for_action(:quit).to_s == key_pressed

      # Check directional keys
      @snake.face_dir(KEYBOARD_COMMANDS[key_pressed.to_sym]) if key_pressed

      # Process the next step and sleep to adjust "framerate"
      break unless step
      draw
      sleep(0.1)
    end
  end

  def randomly_place_food
    @food ||= @grid.rand_point

    while @snake.hit_test(@food)
      @food = @grid.rand_point
    end
  end

  def step
    @snake.step

    # Check bounds and collisions
    return false if !@grid.fits?(@snake.pos_points) || @snake.eating_itself?

    # Check food eating
    if @snake.hit_test(@food)
      # Find a new spot for the food
      randomly_place_food

      # Increase the size of the snake
      @snake.grow
    end

    true
  end

  def draw
    @grid.draw do |point|
      @food == point ? '#' : '.'
      if @snake.hit_test(point)
        '*'
      elsif @food == point
        '#'
      else
        '.'
      end
    end
  end
end
