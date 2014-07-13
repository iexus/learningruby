require_relative "../lib/pancake_sort"

describe PancakeSort do
  describe "Flipping a stack" do

    let(:pancakes) {PancakeSort.new [6,5,4,9,3,2,1]}
    let(:small_stack) {[6,5,4,9,3,2,1]}

    it "will find position of the largest pancake in a stack" do
      expect(pancakes.find_largest_pancake(small_stack)).to eq 3
    end

    it "will flip the stack at an index" do
      expect(pancakes.flip_stack(small_stack, 3)).to eq [6,5,4,1,2,3,9]
    end

    it "will put the largest pancake at the bottom" do
      #6,5,4,9,3,2,1
      #6,5,4,1,2,3,9
      #9,3,2,1,4,5,6
      pancakes.sort_next_largest
      expect(pancakes.pancake_stack[0]).to eq 9
    end

    it "will put the 2 largest pancakes at the bottom" do
      #9,3,2,1,4,5,6
      #9,3,2,1,4,5,6
      #9,6,5,4,1,2,3

      pancakes.sort_next_largest
      pancakes.sort_next_largest
      expect(pancakes.pancake_stack).to eq [9,6,5,4,1,2,3]
    end

    it "will sort until the stack has been sorted" do
      pancakes.sort_until_done
      expect(pancakes.pancake_stack).to eq [9,6,5,4,3,2,1]
    end

    it "will handle sorting 1 pancake" do
      lonely_pancake = PancakeSort.new [4]
      lonely_pancake.sort_until_done
      expect(lonely_pancake.pancake_stack).to eq [4]
    end

    it "will handle a pre-sorted stack" do
      pre_sorted = PancakeSort.new [4,3,2,1]
      pre_sorted.sort_until_done
      expect(pre_sorted.pancake_stack).to eq [4,3,2,1]
    end
  end
end
