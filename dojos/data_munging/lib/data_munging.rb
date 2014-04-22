class DataMunger
  def initialize
    @headers = ""
  end

  def read_headers line
    @headers = line
  end

  def get_value column, line
    range = get_column_range column
    return line[range[0]..range[1]].to_i
  end

  def get_column_index column_name
    index = @headers.index(/#{column_name}/)
    return index == nil ? -1 : index
  end

  def get_column_range column_name
    r_start = get_column_index(column_name)

    if r_start == -1
      return -1
    else
      r_end = r_start + column_name.length - 1 #range is inclusive?
      return [r_start, r_end]
    end
  end
end
