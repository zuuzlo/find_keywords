require 'spec_helper'

describe "FindKeywords" do
  
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
      sentence = "free shipping For women members"
      keywords = FindKeywords::Keywords.new(sentence).keywords
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
  end
end