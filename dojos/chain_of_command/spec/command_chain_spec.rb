require_relative "../lib/command_chain"

describe CommandChain::Reader do
  describe "creating employees" do
    it "will create an employee when given a line of text" do
      record = "  23  |  Mrs. Miggins  |  1  "
      employee = subject.create_from_record record
      expect(employee.name).to eq "Mrs. Miggins"
      expect(employee.id).to eq 23
      expect(employee.boss_id).to eq 1
    end

    it "will set the boss id to 0 for a root employee" do
      record = "1 |  Mr.Big |   "
      employee = subject.create_from_record record
      expect(employee.name).to eq "Mr.Big"
      expect(employee.id).to eq 1
      expect(employee.boss_id).to eq 0
    end
  end
end

describe CommandChain do

  let(:root) {CommandChain::Employee.new(1, "Root", 0)}
  let(:bob) {CommandChain::Employee.new(10, "Bob", 5)}
  let(:bobs_boss) {CommandChain::Employee.new(5, "Bob's Boss", 1)}

  before() {
    @chain = CommandChain.new
    @chain.add_employee root
    @chain.add_employee bob
    @chain.add_employee bobs_boss
  }

  describe "messaging employees" do
    it "can message from an employee to that employees boss" do
      route = @chain.message(10, 5)
      expect(route).to eq "Bob -> Bob's Boss"
    end

    it "can message from an employees boss to their employee" do
      route = @chain.message(5, 10)
      expect(route).to eq "Bob's Boss <- Bob"
    end
  end
end
