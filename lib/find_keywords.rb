require "find_keywords/version"
require "find_keywords/remove_words_list"
require "find_keywords/find_keywords_string"

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
      slug = sentence.downcase
      #slug.gsub!(/(\d{2}|\d{1})\/(\d{2}|\d{1})(-|.-.)(\d{2}|\d{1})\/(\d{2}|\d{1})/, "") #add rev 0.0.2 remove date
      #slug.gsub!(/(sept|oct|nov|dec|jan|feb|mar|apr|may|jun|jul|aug)(\s*)(\d*|)(-|.-.|)/, "") #add rev 0.0.2 remove date
      slug.gsub! /['`]/,""
      slug.gsub! /\s*[^A-Za-z]\s*/, ' '
      slug.gsub!(/ +/,' ')
      slug.gsub!(/^\s|\s$/,'')
      words = slug.downcase.scan(/\w+/)
      keywords = words.select { |word| !remove_words(word_list).include?(word) }
      keywords.delete_if { |word| word.size <= 2 }
      keywords.uniq! if keywords.uniq
      keywords
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
