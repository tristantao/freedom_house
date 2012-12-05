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
end
