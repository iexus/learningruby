require_relative "../lib/data_munging"

describe DataMunger do
    let (:headers) { "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP" }
    let (:first_line) { "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5" }

    describe "finding headers" do
      before(:each) do
        @munger = DataMunger.new
        @munger.read_headers headers
      end

      it "will return -1 if it cannot find a column" do
        expect(@munger.get_column_index "NotAColumn").to eq(-1)
      end

      it "will return the index of a column if found" do
        expect(@munger.get_column_index( "Dy" )).to eq(2)
        expect(@munger.get_column_index( "AvT" )).to eq(17)
      end

      it "will return -1 if it does not find the range of a column" do
        expect(@munger.get_column_range( "notAColumn" )).to eq(-1)
      end

      it "will return the range of a column" do
        expect(@munger.get_column_range( "Dy" )).to eq([2, 3])
        expect(@munger.get_column_range( "HDDay" )).to eq([23, 27])
      end
    end

  describe "reading data from columns" do
    before(:each) do
      subject.read_headers headers
    end

    it "will read the value of a given column" do
      expect(subject.get_value( "Dy", first_line )).to eq(1)
    end

    it "will read the day from a line" do
      expect(subject.get_value( "Dy", first_line)).to eq(1)
      expect(subject.get_value( "Dy", "   9")).to eq(9)
    end

    it "will return day numbers with 2 digits from a line" do
      expect(subject.get_value( "Dy", "  23")).to eq(23)
    end

    it "will return max temp from a line" do
      expect(subject.get_value( "MxT", "   1  88")).to eq(88)
      expect(subject.get_value( "MxT", "  23   1")).to eq (1)
    end

    it "will return min temp from a line" do
      expect(subject.get_value( "MnT", "   3  77    55")).to eq(55)
      expect(subject.get_value( "MnT", "   3  77     1")).to eq(1)
    end
  end
end
