# -----------------------------------------------------------------------------
# Handles moving of Rover on Mars
class Rover
  attr_reader :coordinates
  attr_reader :orientation
  attr_reader :path_pattern
  attr_reader :mars

  # ---------------------------------------------------------------------------
  def initialize(coordinates, orientation, path_pattern, mars)
    @coordinates = coordinates
    @orientation = orientation
    @path_pattern = path_pattern
    @mars = mars
  end

  # ---------------------------------------------------------------------------
  def print_current_state
    puts "Coordinates: #{@coordinates}"
    puts "Orientation:  #{@orientation}"
  end

  # ---------------------------------------------------------------------------
  def traverse_path
    @path_pattern.split('').each do |direction|
      @coordinates, @orientation = @mars.obtain_new_position(@coordinates,
                                                             @orientation,
                                                             direction)

      if @mars.is_not_valid?(*@coordinates)
        puts 'Not a valid move. Out of Mars :\'('
        exit
      end
    end
  end
end
