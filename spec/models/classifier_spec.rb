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
      s = mock("Source")
      s.stub(:nil?).and_return(false)
      s.stub(:progress_classify=).and_return("")
      s.stub(:save).and_return(true)
      mockArticle.stub(:save!).and_return(true)
      mockArticle.stub(:contains_hatespeech).and_return(true)
      mockArticle.stub(:contains_hatespeech=).and_return(true)
      mockArticle2.stub(:save!).and_return(true)
      mockArticle2.stub(:contains_hatespeech).and_return(true)
      mockArticle2.stub(:contains_hatespeech=).and_return(true)
      article_list = [mockArticle, mockArticle2, mockArticle, mockArticle2, mockArticle, mockArticle2]
      classifier = Classifier.new(:problem => "wizard", :top_features => ["testing","sucks"], :on_off => false)
      classifier.classify(article_list, s).should be_true
    end

    it "should be able to retrain a feature vector" do
      classifier = Classifier.create!(:problem => "wizard", :top_features => ["Hagrid", "testing", "sucks", "harry", "wizard"], :on_off => false, :accuracy => 0.0)
      mockArticle = Article.new(:title => "Harry Potter", :date => 'Jan 1, 2011', :author => 'J.K Rowing', :link => 'harrypotter.com', :text => 'harry, youre a wizard. Said Hagrid', :contains_hatespeech => true)
      mockArticle.stub(:save).and_return(true)
      mockArticle.stub(:save!).and_return(true)


      Article.stub(:all).and_return([mockArticle, mockArticle])

      classifier.retrain.should be_true

    end
  end
end
