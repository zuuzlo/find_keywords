require 'spec_helper'

describe "FindKeywords" do
  describe "Keywords" do
    context "errors" do
    
      it "requires a string" do
        expect {FindKeywords::Keywords.new}.to raise_error(ArgumentError)
      end

      it "returns blank on nil input" do
        sentence = nil
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq([])
      end

      it "splits an array to string" do
        sentence = ["the", "fox", "shoes"]
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["fox", "shoes"])
      end

      it "convert hash to string" do
        sentence = { the: "big dog", animal: "fox", wears: "shoes" }
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["big", "dog", "animal", "fox", "wears", "shoes"])
      end

      it "retuns no key words for numbers" do
        sentence = 567
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq([])
      end
    end

    context "remove unneeded characters" do

      it "removes $ % inside words" do
        sentence = "The $100 savings$20 cashback save%20 now"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["savings", "cashback", "save"])
      end

      it "removes apostrophes" do
        sentence = "Kirk's"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(['kirks'])
      end
      
      it "removes symbols @ and &" do
        sentence = "@kirk & jarvis"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(['kirk', 'jarvis'])
      end

      it "replace all non alphanumeric, underscore or periods with blank" do
        sentence = "@kirk & jarvis_ the ship. $ %"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(['kirk', 'jarvis', 'ship'])
      end
      
      it "replace all numbers with nothing" do
        sentence = "@kirk & jarvis_ the ship. $ 20 %"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(['kirk', 'jarvis', 'ship'])
      end

      it "downcases all words" do
        sentence = "@kirk & JARVIS_ the ship. $ 20 %"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(['kirk', 'jarvis', 'ship'])
      end

      it "removes stop words" do
        sentence = "The quick brown fox jump over the lazy dog."
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["quick", "brown", "fox", "jump", "lazy", "dog"])
      end

      it "removes industry specific words" do
        industry_specific_words= FindKeywords::RemoveWordsList.new(%w(free shipping members for))
        sentence = "free shipping For women members"
        keywords = FindKeywords::Keywords.new(sentence, industry_specific_words).keywords
        expect(keywords).to eq(["women"])
      end

      it "removes duplicutes" do
        sentence = "women women women"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["women"])
      end

      it "removes words less than 2 characters" do
        sentence = "ta vg the game"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["game"])
      end

      it "removes leading and trailing underscore" do
        sentence = "_the yellow__jeans_"
        keywords = FindKeywords::Keywords.new(sentence).keywords
        expect(keywords).to eq(["yellow", "jeans"])
      end

      it "removes date Oct - 25 and specific removal list" do
        industry_specific_words = FindKeywords::RemoveWordsList.new(%w(code with sept oct))
        sentence = "Dana Buchman Apparel with code DANA10. Sept 24 – Oct 4 10-20-2014"
        keywords = FindKeywords::Keywords.new(sentence, industry_specific_words).keywords
        expect(keywords).to eq(["dana", "buchman", "apparel"])
      end
    end
    context "with custom and stop word removal lists" do
      context "all_custom" do
        it "only removes words from multiple remove word lists" do
          industry_specific_words = FindKeywords::RemoveWordsList.new(%w(class with))
          simple_words = FindKeywords::RemoveWordsList.new(%w(this a is means))
          sentence = "This means that a class definition is executed with that class"
          keywords = FindKeywords::Keywords.new(sentence, "all_custom").keywords
          expect(keywords).to eq(["that", "definition", "executed"])
        end
      end

      context "all - both custon and stop words list" do
        it "removes words from multiple remove word lists and stop words list" do
          industry_specific_words = FindKeywords::RemoveWordsList.new(%w(gem parsing))
          simple_words = FindKeywords::RemoveWordsList.new(%w(please note using simple))
          sentence = "Please note that this gem is using an extremely simple language natural processor, so parsing is not perfect, but it works."
          keywords = FindKeywords::Keywords.new(sentence, "all").keywords
          expect(keywords).to eq(["extremely", "language", "natural", "processor", "perfect", "works"])
        end
      end
    end

  end
  describe "RemoveWordsList" do
    describe ".stop_words" do
      let(:words) { FindKeywords::RemoveWordsList.stop_words }
      it "returns array of stop words" do
        expect(words).to be_kind_of(Array)
      end

      it "last word is yourselves" do
        expect(words.last).to eq("yourselves")
      end
    end

    describe ".word_list" do
      let(:words) { FindKeywords::RemoveWordsList.new(%w(the is a and know)) }

      it "returns word list" do
        expect(words.word_list.last).to eq("know")
      end
    end

    describe ".all_custom" do
      before do
        FindKeywords::RemoveWordsList.new(%w(the is a and know))
        FindKeywords::RemoveWordsList.new(%w(easiest way to mnemonically))
        FindKeywords::RemoveWordsList.new(%w(Can you point me))
      end

      it "returns array of all words" do
        expect(FindKeywords::RemoveWordsList.all_custom).to be_kind_of(Array)
      end

      it "last word is yourselves" do
        expect(FindKeywords::RemoveWordsList.all_custom.last).to eq("me")
      end
    end
  end
  
  describe "find_keywords_string" do
    describe ".keywords" do
      it "returns keywords from string" do
        expect("the is a and know".keywords).to eq(["know"])
      end
    end
  end
end