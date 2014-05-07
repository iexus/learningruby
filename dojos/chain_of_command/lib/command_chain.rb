class CommandChain
  attr_reader :employees

  def initialize
    @employees = Hash.new
  end

  def add_employee employee
    @employees[employee.id] = employee
  end

  def find_boss employee
    @employees.each_value do |value|
      if value.id == employee.boss_id
        return value
      end
    end

    #We didn't find anyone, so either root or no match.
    return nil
  end

  def message from_id, to_id
    puts " "
    start = @employees[from_id]
    path = start.do_you_know(to_id, from_id, [])
    return path
  end

  def build_chain
    @employees.each_value do |value|
      value.reset
    end

    @employees.each_value do |value|
      boss = find_boss(value)
      boss.add_child(value) unless boss == nil
      value.add_boss(boss) unless boss == nil
    end
  end

  def format_route route
    output = ""
    previous = nil
    route.each do |node|
      if previous != nil
        if node.id == previous.boss_id
          output += "->"
        else
          output += "<-"
        end
      end
      output += " #{node.name} "
      previous = node
    end

    return output
  end

  class Employee
    attr_reader :id
    attr_reader :name
    attr_reader :boss_id
    attr_reader :boss
    attr_reader :children

    def initialize id, name, boss_id
      @id = id
      @name = name
      @boss_id = boss_id
      @boss = nil
      @children = []
    end

    def reset
      @children = []
      @boss = nil
    end

    def inspect
      "employee #{@name}"
    end

    def add_child child
      @children << child
    end

    def add_boss boss
      @boss = boss
    end

    def do_you_know this_id, origin_id, current_path
      my_path = (current_path.dup) << self
      if this_id == @id
        return my_path
      end

      @children.each do |value|
        if value.id != origin_id
          new_path = value.do_you_know(this_id, @id, my_path)
          if new_path != nil
            return new_path
          end
        end
      end

      if @boss.id != origin_id
        boss_new_path = @boss.do_you_know(this_id, @id, my_path)
        if boss_new_path != nil
          return boss_new_path
        end
      end

      return nil
    end

  end

  class Reader
    def create_from_record line
      attr = line.split("|")
      Employee.new(attr[0].to_i, attr[1].strip, attr[2].to_i)
    end
  end
end
