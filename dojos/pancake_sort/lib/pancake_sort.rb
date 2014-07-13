class PancakeSort
  attr_reader :pancake_stack

  def initialize stack
    @pancake_stack = stack
    @place_in_stack = 0
  end
  
  def find_largest_pancake stack
    stack.index(stack.max)
  end

  def flip_stack stack, point_to_flip
    stack[point_to_flip..-1] = stack[point_to_flip..-1].reverse
    return stack
  end

  def sort_next_largest
    sub_array = @pancake_stack[@place_in_stack..-1]
    index = find_largest_pancake sub_array
    flip_stack @pancake_stack, index + @place_in_stack
    flip_stack @pancake_stack, @place_in_stack
    @place_in_stack += 1
  end

  def sort_until_done
    @place_in_stack = 0
    while (@place_in_stack < @pancake_stack.length)
      sort_next_largest
    end
  end
end
