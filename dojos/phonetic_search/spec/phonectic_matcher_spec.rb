require_relative "../lib/phonetic_matcher"

describe PhoneticMatcher do
  
  let (:surnames_text) {
    surnames = []
    
    File.open("surnames.txt", "r") do |f|
      f.each_line do |line|
        surnames << line.delete("\n")
      end
    end

    return surnames
  } 

  describe "alphabetising text" do
    it 'will remove all non-alphabetical characters' do
      result = subject.alphabetise 'letters2387numbers*&^$\\symbols'
      expect(result).to eq 'lettersnumberssymbols'
    end

    it 'will retain spaces between words' do
      result = subject.alphabetise 'Mac Donalds Farm'
      expect(result).to eq 'Mac Donalds Farm'
    end

  end

  describe "discarding vowel like characters" do
    it 'will remove the following letters after the first: a-e-i-o-u-h-w-y' do
      expect(subject.discard 'Aardvark').to eq 'Ardvrk'
    end

    it 'will handle a small word' do
      expect(subject.discard 'b').to eq 'b'
    end

    it 'will not retain white space whilst removing' do
      expect(subject.discard 'Brilliant Bonobo').to eq 'BrllntBnb'
    end
  end

  describe "generating possible matches" do
    it "will generate a coded key of possible matches" do
      expect(subject.generate_match_key "aeiou").to eq "00000"
      expect(subject.generate_match_key "cgjkqsxyz").to eq "111111111"
      expect(subject.generate_match_key "bfpvw").to eq "22222"
      expect(subject.generate_match_key "dt").to eq "33"
      expect(subject.generate_match_key "mn").to eq "44"
    end

    it "will not care about case" do
      expect(subject.generate_match_key "ACBDM").to eq "01234"
    end

    it "will add *'s in place of letters which do not matter" do
      expect(subject.generate_match_key "hlr").to eq "***"
    end

    it "will consider consecutive letters as one instance" do
      expect(subject.generate_match_key "aaabbccchhh").to eq "021*"
    end
  end

  describe "generating surnames mappings" do
    it "will create a map based on generated key for a surname" do

      #Take Smith, discard letters and get Smt
      #convert this into a key and we get 143

      expected_result = { "143" => ["Smith"] }
      expect(subject.generate_surname_map ["Smith"]).to eq expected_result
    end

    it "will add multiple surnames to the same key if they match" do
      #Jonas goes to jns which maps to 141
      #Johns goes to jns ..
      #Saunas goes to sns which maps to 141
      expected_result = { "141" =>  ["Jonas", "Johns", "Saunas"]}
      expect(subject.generate_surname_map ["Jonas", "Johns", "Saunas"]).to eq expected_result
    end

    it "will have multiple keys in the mapping" do
      expected_result = { "141" => ["Jonas", "Johns", "Saunas"],
                          "143" => ["Smith"] }
      expect(subject.generate_surname_map ["Jonas", "Johns", "Saunas", "Smith"]).to eq expected_result
    end
  end

  describe "finding surname matches" do
    it "will return an array of matches if found" do
      subject.generate_surname_map surnames_text 
      expect(subject.find_match "Jones").to eq ["Jonas", "Johns", "Saunas"]
    end

    it "will say that Winton is totally like Van Damme" do
      subject.generate_surname_map surnames_text
      expect(subject.find_match "Winton").to eq ["Van Damme"]
    end
  end
end
