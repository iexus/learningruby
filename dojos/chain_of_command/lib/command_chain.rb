class CommandChain

  def initialize
    @employees = Hash.new
  end

  def add_employee employee
    @employees[employee.id] = employee
  end

  def message from_id, to_id
    direction = "->"
    
    #are we sending from the boss?
    if from_id == @employees[to_id].boss_id
      direction = "<-"
    end

    return "#{@employees[from_id].name} #{direction} #{@employees[to_id].name}"
  end

  Employee = Struct.new(:id, :name, :boss_id)

  class Reader
    def create_from_record line

      attr = line.split("|")
      id = attr[0].to_i
      name = attr[1].strip
      boss_id = attr[2].to_i

      Employee.new(id, name, boss_id)
    end
  end
end
