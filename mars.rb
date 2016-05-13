# -----------------------------------------------------------------------------
# Mars class to handle moving on the grid
class Mars
  # ---------------------------------------------------------------------------
  def initialize(m, n)
    @m = m
    @n = n
    @left_right_conversion = { 'N' => ['W', 'E'],
                               'E' => ['N', 'S'],
                               'S' => ['E', 'W'],
                               'W' => ['S', 'N'] }
  end

  # ---------------------------------------------------------------------------
  def modify_coordinates(old_coordinates, old_orientation)
    if old_orientation == 'N'
      return old_coordinates[0], old_coordinates[1] + 1
    elsif old_orientation == 'S'
      return old_coordinates[0], old_coordinates[1] - 1
    elsif old_orientation == 'E'
      return old_coordinates[0] + 1, old_coordinates[1]
    elsif old_orientation == 'W'
      return old_coordinates[0] - 1, old_coordinates[1]
    end
  end

  # ---------------------------------------------------------------------------
  def is_not_valid?(x, y)
    return !(x >= 0 && x <= @m && y >= 0 && y <= @n)
  end

  # ---------------------------------------------------------------------------
  def obtain_new_position(old_coordinates, old_orientation, direction)
    if direction == 'M'
      return [modify_coordinates(old_coordinates, old_orientation),
              old_orientation]
    elsif direction == 'L'
      return [old_coordinates, @left_right_conversion[old_orientation][0]]
    elsif direction == 'R'
      return [old_coordinates, @left_right_conversion[old_orientation][1]]
    else
      raise('Invalid direction in the input')
    end
  end
end
