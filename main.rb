require 'pry'

class Mars
  def initialize(m, n)
    @m = m
    @n = n
    @left_right_conversion = { 'N': ['W', 'E'],
                               'E': ['N', 'S'],
                               'S': ['E', 'W'],
                               'W': ['S', 'N'] }
  end

  def modify_coordinates(old_coordinates, old_orientation)
    x = old_coordinates[0]
    y = old_coordinates[1]
    if old_orientation == 'N'
      return x, y + 1
    elsif old_orientation == 'S'
      return x, y - 1
    elsif old_orientation == 'E'
      return x + 1, y
    elsif old_orientation == 'W'
      return x - 1, y
    end
  end

  def obtain_new_position(old_coordinates, old_orientation, direction)
    new_coordinates = old_coordinates
    if direction == 'M'
      orientation = old_orientaion
      new_coordinates = modify_coordinates(old_coordinates, old_orientation)
    elsif direction == 'L'
      orientation = @left_right_conversion[old_orientation[0]]
    elsif direction == 'R'
      orientation = @left_right_conversion[old_orientation[1]]
    else
      raise RuntimeError, 'Invalid orientation found in input'
    end
  end
end

class Rover
  def initialize(coordinates, orientation, path_pattern, mars)
    @coordinates = coordinates
    @orientation = orientation
    @path_pattern = path_pattern
    @mars = mars
  end

  def print_current_state
    puts "Coordinates: #{@coordinates}"
    puts "Orientation:  #{@orientation}"
  end

  def traverse_path
    @path_pattern.split('').each do |direction|
      @coordinates, @orientaion = @mars.obtain_new_position(@coordinates,
                                                            @orientation,
                                                            direction)
    end
  end
end

class ProcessInput
  attr_reader :lines, :test_cases

  def initialize(complete_input)
    @complete_input = complete_input
    @lines = complete_input.split("\n")
    @test_cases = @lines.length - 1
    if @test_cases % 2 == 0
      @test_cases /= 2
    else
      raise RuntimeError, "Invalid number of testcases"
    end
  end

  def obtain_dimensions
    dimensions = @lines[0].strip
    dimensions.split(' ').map { |x| x.to_i }
  end

  def obtain_current_state(i)
    @lines[2 * i + 1].strip.split(' ')
  end

  def obtain_path_pattern(i)
    @lines[2 * i + 2].strip
  end
end

if __FILE__ == $PROGRAM_NAME

  complete_input = gets(nil)
  process_input = ProcessInput.new(complete_input)

  mars_dimensions = process_input.obtain_dimensions
  mars = Mars.new(*mars_dimensions)
  process_input.test_cases.times do |i|
    current_state = process_input.obtain_current_state(i)
    path_pattern = process_input.obtain_path_pattern(i)
    rover = Rover.new([current_state[0].to_i, current_state[1].to_i],
                      current_state[2],
                      path_pattern,
                      mars)
    rover.traverse_path
    rover.print_current_state
  end

end

