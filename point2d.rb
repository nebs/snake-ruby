class Point2D
  include Comparable

  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(point)
    @x == point.x && @y == point.y
  end

  alias eql? ==

  def hash
    [@x, @y].hash
  end

  def +(point)
    Point2D.new(@x + point.x, @y + point.y)
  end
end
