# -----------------------------------------------------------------------------
# Process the user input
class ProcessInput
  attr_reader :lines, :test_cases

  # ---------------------------------------------------------------------------
  def initialize(complete_input)
    @complete_input = complete_input
    @lines = complete_input.split("\n")
    @test_cases = @lines.length - 1
    validate_test_case_size
  end

  # ---------------------------------------------------------------------------
  def validate_test_case_size
    @test_cases.even? ? @test_cases /= 2 : raise('Invalid number of testcases')
  end

  # ---------------------------------------------------------------------------
  def obtain_dimensions
    dimensions = @lines[0].strip
    dimensions.split(' ').map { |i|
      integer = Integer(i)
      raise('Negative Integer not allowed for coordinates') if integer < 0
      integer
    }
  end

  # ---------------------------------------------------------------------------
  def is_i?(c)
    c.to_i == Integer(c)
  end

  # ---------------------------------------------------------------------------
  def obtain_current_state(i)
    current_state = @lines[2 * i + 1].strip.split(' ')
    current_state[0] = current_state[0].to_i if is_i?(current_state[0])
    current_state[1] = current_state[1].to_i if is_i?(current_state[1])
    'NSEW'.include?(current_state[2]) ? current_state : raise('Invalid initial orientation')
  end

  # ---------------------------------------------------------------------------
  def obtain_path_pattern(i)
    path_pattern = @lines[2 * i + 2].strip
    path_pattern.split('').each do |direction|
      raise('Invalid direction in path pattern') if 'MLR'.include?(direction) == false
    end
    path_pattern
  end
end
