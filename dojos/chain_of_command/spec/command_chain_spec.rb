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
  let(:simon) {CommandChain::Employee.new(24, "Simon", 1)}
  let(:paul) {CommandChain::Employee.new(21, "Paul", 24)}
  let(:peter) {CommandChain::Employee.new(99, "Peter", 24)}
  let(:homer) {CommandChain::Employee.new(35, "Homer", 1)}

  before() {
    @chain = CommandChain.new
    @chain.add_employee homer
    @chain.add_employee root
    @chain.add_employee paul
    @chain.add_employee peter
    @chain.add_employee bob
    @chain.add_employee bobs_boss
    @chain.add_employee simon
    @chain.build_chain
  }

  describe "building a chain" do
    it "can find the boss for an employee" do
      expect(@chain.find_boss bob).to eq bobs_boss
      expect(@chain.find_boss bobs_boss).to eq root
    end

    it "will return nil for the boss of a root" do
      expect(@chain.find_boss root).to eq nil
    end

    it "will build a list of known children for a boss" do
      sally = CommandChain::Employee.new(11, "Sally", 5)
      @chain.add_employee sally
      @chain.build_chain
      expect(bobs_boss.children).to eq [bob, sally]
    end

    it "will link directly the boss onto the employee" do
      expect(bobs_boss.boss).to eq root
      expect(bob.boss).to eq bobs_boss
    end
  end

  describe "messaging employees" do
    it "can message from an employee to that employees boss" do
      expect(@chain.message(10, 5)).to eq([bob, bobs_boss])
    end

    it "can message from an employees boss to their employee" do
      expect(@chain.message(5, 10)).to eq([bobs_boss, bob])
    end

    it "messages to another employee via a boss" do
      sally = CommandChain::Employee.new(11, "Sally", 5)
      @chain.add_employee sally
      @chain.build_chain
      expect(@chain.message(11, 10)).to eq([sally, bobs_boss, bob])
    end

    it "messages another a bosses boss" do
      expect(@chain.message(10, 1)).to eq([bob, bobs_boss, root])
    end

    it "will look across the organisation" do
      expect(@chain.message(10, 21)).to eq ([bob, bobs_boss, root, simon, paul])
    end
  end

  describe "formatting route" do
    it "adds an up arrow (->) for messaging a boss" do
      expect(@chain.format_route(@chain.message(10, 5))).to eq " Bob -> Bob's Boss "
    end

    it "adds a down arrow (<-) for messaging an employee from a boss" do
      expect(@chain.format_route(@chain.message(5, 10))).to eq " Bob's Boss <- Bob "
    end

    it "can add arrows for both up and down" do
      expect(@chain.format_route(@chain.message(10, 21))).to eq " Bob -> Bob's Boss -> Root <- Simon <- Paul "
    end
  end
end
