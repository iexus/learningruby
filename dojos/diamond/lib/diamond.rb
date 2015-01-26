class Diamond

  def print_diamond(middle_character)
    top_triangle = get_triangle(character: middle_character)
    return (top_triangle + top_triangle.reverse[1..-1]).join("\n")
  end

  def get_triangle(character:)
    top_characters = ('A'..character).to_a
    top_characters.each_with_index.map do |char, index|
      get_line(character: char, index: index, length: top_characters.length)
    end
  end

  def get_line(character:, index:, length:)
    line = " " * (length - index - 1) + character

    if character != 'A'
      line += " " * (index * 2 - 1) + character
    end

    line
  end

end
