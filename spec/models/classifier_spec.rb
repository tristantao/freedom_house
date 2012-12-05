require 'spec_helper'
require_relative '../../lib/chi_squared'
include ::ChiSquared

describe Classifier do
  describe "Calculating Chi_squraed" do
    it "shoudl be able to calculate chi squared for sample articles and sample feature vector" do
      sample_label = [0,0,0,0,0,1,1,1,1,1]
      sample_doc_array = ["this is a sample array",
                          "this is the second sample array",
                          "this is the third sample array",
                          "this is the fourth sample array",
                          "this is the fifth sample array",
                          "this is the sixth sample array",
                          "this is the seventh sample array",
                          "this is the eighth sample array",
                          "this is the nineth sample array",
                          "this is the tenth sample array"]
      sample_feature_vector = ["this", "seventh", "a", "tenth", "array"]
      test = chi_squared(sample_label, sample_doc_array, sample_feature_vector, 3)
      result = ["this", "seventh", "a"] == test
      result.should be_true
    end
  end
  describe "classifying articles " do
    it "should be able to classify sample articles" do
      mockArticle = mock("Article", :id => '1', 'title' => "Harry Potter", 'date' => 'Jan 1, 2011', 'author' => 'J.K Rowing', 'link' => 'harrypotter.com', 'text' => 'harry, youre a wizard')
      #Article.should_receive(:create).and_return(mockArticle)
      mockArticle2 = mock("Article", :id => '2', 'title' => "Harry Potter two", 'date' => 'Jan 1, 2012', 'author' => 'J.K Rowing', 'link' => 'harrypotter2.com', 'text' => 'harry, youre a wizard, for the second time!')
      #Article.should_receive(:create).and_return(mockArticle2)
      mockArticle.stub(:contains_hatespeech)
      mockArticle.stub(:text)
      mockArticle.stub(:save!)
      mockArticle2.stub(:contains_hatespeech)
      mockArticle2.stub(:text)
      mockArticle2.stub(:save!)

      article_list = [mockArticle, mockArticle2]
      classifier = mock("Classifier", :id => '1', :problem => "test", :top_feature => ["testing","sucks"], :on_off => false)
      classifier.stub(:top_features)
      classifier.should_receive(:classify).with(article_list, nil).and_return(true)
      classifier.classify(article_list, nil)
    end
  end
end
