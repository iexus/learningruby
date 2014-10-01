require_relative '../lib/package_manager'

describe PackageManager do
  let(:line) {"gui -> awtui swingui"}
  before(:each) do
    @package = subject.create_package line
  end
  describe "creating packages" do

    it "will take a line and create a package with a name" do
      expect(@package.name).to eq "gui"
    end

    it "will create dependencies" do
      expect(@package.dependencies).to eq [ "awtui", "swingui" ]
    end

    it "will check if dependency exists in package" do
      expect(@package.contains("awtui")).to eq true
    end
  end

  describe "registering packages" do
    it "will add packages to package manager" do
      subject.register_package @package
      expect(subject.contains("gui")).to eq true
    end

    it "will return a package if registered" do
      subject.register_package @package
      expect(subject.retrieve("gui")).to eq @package
    end
  end
end
