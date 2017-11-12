require "find_keywords"

class String 
  def keywords
    FindKeywords::Keywords.new(self).keywords
  end
end