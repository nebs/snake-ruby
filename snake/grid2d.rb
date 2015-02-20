require_relative 'point2d'

class Grid2D
  def initialize(num_columns, num_rows)
    @num_rows = num_rows
    @num_cols = num_columns
  end

  def draw
    @num_rows.times do |r|
      @num_cols.times do |c|
        print yield(Point2D.new(c, r))
      end
      print "\n"
    end
  end

  def rand_point
    Point2D.new(rand(@num_cols), rand(@num_cols))
  end

  def fits?(points)
    points.each do |p|
      return false if p.x < 0 || p.x >= @num_rows ||
                      p.y < 0 || p.y >= @num_cols
    end

    true
  end
end
