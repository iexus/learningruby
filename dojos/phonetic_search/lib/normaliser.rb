class Normaliser

  def alphabetise text
    text.gsub(/[^a-zA-Z\s]/, '')
  end 

  def discard text
    result = text[0]

    if text.length > 1
      result += text[1, text.length].gsub(/[aeiouhwy]/, '')
    end
    
    return result
  end
end
