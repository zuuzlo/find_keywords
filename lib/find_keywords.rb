require "find_keywords/version"
require "find_keywords/remove_words_list"

module FindKeywords
  class Keywords

    attr_accessor :sentence
    attr_reader :keywords

    def initialize (sentence, word_list = "stop_words")
      if sentence.is_a?(String)
        @sentence = sentence
      elsif sentence.is_a?(Array)
        @sentence = sentence.join(' ')
      elsif sentence.is_a?(Hash)
        @sentence = sentence.collect { |k, v| "#{k} #{v} " }.join
      else
        @sentence = ''
      end
      @keywords = find_keywords(@sentence, word_list)
    end

    private

    def find_keywords(sentence, word_list)
      #remove_words = FindKeywords::RemoveWordsList.stop_words
      slug = sentence.downcase
      slug.gsub!(/(\d{2}|\d{1})\/(\d{2}|\d{1})(-|.-.)(\d{2}|\d{1})\/(\d{2}|\d{1})/, "") #add rev 0.0.2 remove date
      slug.gsub!(/(sept|oct|nov|dec|jan|feb|mar|apr|may|jun|jul|aug)(\s*)(\d*|)(-|.-.|)/, "") #add rev 0.0.2 remove date
      slug.gsub! /['`]/,""
      slug.gsub! /\s*@\s*/, " at "
      slug.gsub! /\s*&\s*/, " and "
      slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, ' '
      #slug.gsub! /\ \d+/, ''
      slug.gsub!(/[^a-zA-Z ]/,'')
      slug.gsub!(/ +/,' ')
      #convert double underscores to single
      #slug.gsub! /_+/,"_"
      #strip off leading/trailing underscore
      #slug.gsub! /\A[_\.]+|[_\.]+\z/,""  
      words = slug.downcase.scan(/\w+/)
      slug_words = words.select { |word| !remove_words(word_list).include?(word)}
      #slug_words = words.select { |word| !STOP_WORDS.include?(word)}
      #slug_words = slug_words.select { |word| !MARKET_WORDS.include?(word)}
      slug = slug_words.join(' ')
      keywords = slug.scan(/\w+/)
      keywords.delete_if { |word| word.size <= 2 }
      keywords.uniq! if keywords.uniq
      return keywords
    end

    def remove_words(word_list)
      case word_list
      when "stop_words"
        FindKeywords::RemoveWordsList.stop_words
      when "all_custom"
        FindKeywords::RemoveWordsList.all_custom
      when "all"
        FindKeywords::RemoveWordsList.all
      else
        if word_list.is_a?(FindKeywords::RemoveWordsList)
          word_list.word_list
        else
          FindKeywords::RemoveWordsList.stop_words
        end
      end
    end
  end
end
