class PackageManager
  def initialize
    @packages = {}
  end

  def create_package (line) 
    line_contents = line.split(" ")
    name = line_contents[0]
    dependencies = line_contents[2..-1]
    Package.new(name, dependencies)
  end

  def register_package (package)
    @packages[package.name] = package
  end

  def contains (package_name)
    @packages.include?(package_name)
  end

  Package = Struct.new(:name, :dependencies) do
    def contains (dependency_name)
      dependencies.include?(dependency_name)
    end
  end
end
