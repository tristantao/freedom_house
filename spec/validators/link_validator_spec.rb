require 'spec_helper'

describe LinkValidator do
  describe "validates improper link" do
    it 'should invalidate a link that does not start with http:' do
      value = "www.google.com"
      record = mock("Object")
      record.should_receive(:errors).at_least(1).times
    end
    it  "should invalidate imroperly formatted url" do
      value = "http:// 211 12../"
      record = Object.new
      record.should_receive(:errors).at_least(2).times
    end
    it "should invalidate fake sites" do
      value = "http://www.fjfjfjfjfjfjfjfjfjfj.com/"
      record = Object.new
      record.should_receive(:errors).at_least(2).times
    end
  end
end
