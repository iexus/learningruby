require 'spec_helper'
require 'diamond'

describe Diamond do

  describe '#print_diamond' do
    it 'will return only A if given A' do
      expect(subject.print_diamond('A')).to eq "A"
    end

    it 'will return a complete diamond with a character as the middle' do
      expect(subject.print_diamond('C')).to eq "  A\n B B\nC   C\n B B\n  A"
    end

    it "will return a bigger diamond because why not, FOR SCIENCE!!!" do
      expect(subject.print_diamond('E')).to eq "    A\n   B B\n  C   C\n D     D\nE       E\n D     D\n  C   C\n   B B\n    A"
    end
  end

  describe '#get_line' do
    it 'will return only A for the first line' do
      expect(subject.get_line(character: 'A', index: 0, length: 3)).to match(/^  A$/)
    end

    it 'will add the left spacing to a line before a character' do
      expect(subject.get_line(character: 'B', index: 1, length: 3)).to match(/^ B/)
    end

    it 'will add the middle spacing to a line in between the 2 characters' do
      expect(subject.get_line(character: 'B', index: 1, length: 3)).to match(/^ B B/)
      expect(subject.get_line(character: 'C', index: 2, length: 3)).to match(/^C   C/)
    end
  end

  describe '#get_triangle' do
    it 'will return a triangle of the first half' do
      expect(subject.get_triangle(character: 'C')).to eq ["  A", " B B", "C   C"]
    end
  end

end

__END__
  A
 B B
C   C

    A
   B B
  C   C
 D     D
E       E
