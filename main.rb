require_relative 'process_input'
require_relative 'mars'
require_relative 'rover'

# -----------------------------------------------------------------------------
if __FILE__ == $PROGRAM_NAME
  complete_input = gets(nil)
  process_input = ProcessInput.new(complete_input)

  mars_dimensions = process_input.obtain_dimensions
  mars = Mars.new(*mars_dimensions)
  process_input.test_cases.times do |i|
    current_state = process_input.obtain_current_state(i)
    path_pattern = process_input.obtain_path_pattern(i)
    rover = Rover.new([current_state[0], current_state[1]],
                      current_state[2],
                      path_pattern,
                      mars)
    rover.traverse_path
    rover.print_current_state
  end
end
