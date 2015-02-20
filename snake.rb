require_relative 'point2d'

class MobileCell
  attr_accessor :pos, :dir

  DIR_POINTS = {
    up:    Point2D.new(0, -1),
    down:  Point2D.new(0, 1),
    left:  Point2D.new(-1, 0),
    right: Point2D.new(1, 0)
  }

  def initialize(x, y, dir)
    @pos = Point2D.new(x, y)
    @dir = dir
  end

  def step
    @pos += DIR_POINTS[@dir]
  end
end

class Snake
  def initialize(c, r, length)
    @body_cells = []
    @current_dir = :up
    length.times do |i|
      @body_cells << MobileCell.new(c, r + i, @current_dir)
    end
  end

  def pos_points
    @body_cells.map(&:pos)
  end

  def grow
    last_cell = @body_cells.last
    last_x = last_cell.pos.x
    last_y = last_cell.pos.y
    last_dir = last_cell.dir

    new_x = last_x
    new_y = last_y
    new_dir = last_dir

    case last_dir
    when :up
      new_y += 1
    when :down
      new_y -= 1
    when :left
      new_x += 1
    when :right
      new_x -= 1
    end

    @body_cells << MobileCell.new(new_x, new_y, new_dir)
  end

  def hit_test(test_point)
    @body_cells.each do |cell|
      return true if cell.pos == test_point
    end

    false
  end

  def eating_itself?
    !!pos_points.uniq!
  end

  def step
    @body_cells.each(&:step)

    last_dir = nil
    @body_cells.each_with_index do |cell, i|
      dir = cell.dir
      cell.dir = i == 0 ? @current_dir : last_dir
      last_dir = dir
    end
  end

  def face_dir(new_dir)
    @current_dir = new_dir if new_dir
  end
end
