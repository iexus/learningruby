require_relative "../lib/normaliser"

describe Normaliser do

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

    it 'will retain white space whilst removing' do
      expect(subject.discard 'Brilliant Bonobo').to eq 'Brllnt Bnb'
    end
  end

end
