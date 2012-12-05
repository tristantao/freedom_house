require 'spec_helper'

describe LinkValidator do
  describe "validates improper link" do
    before(:each) do
      @validator = LinkValidator.new({:attributes => {}})
      @mock = mock('model')
      @mock.stub("errors").and_return([])
      @mock.errors.stub('[]').and_return({})
      @mock.errors[].stub('<<')
    end

    it "should invalidate a link that does not start with http:" do
      @mock.errors[].should_receive('<<')
      @validator.validate_each(@mock, "link", "www.google.com")
    end

    it "should invalidate imroperly formatted url" do
      @mock.errors[].should_receive('<<')
      @validator.validate_each(@mock, "link", "http:// 211 12../")
    end

    it "should invalidate fake sites" do
      @mock.errors[].should_receive('<<')
      @validator.validate_each(@mock, "link", "http://www.fjfjfjfjfjfjfjfjfjfj.com/")
    end
  end
end
