require 'spec_helper'

describe RssValidator do
  before(:each) do
    @validator = RssValidator.new({:attributes => {}})
    @mock = mock('model')
    @mock.stub("errors").and_return([])
    @mock.errors.stub('[]').and_return({})
    @mock.errors[].stub('<<')
  end
  it 'should invalidate a link that does not start with http://' do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "link", "www.google.com")
  end
  it 'should invalidate a resource that does not exist' do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "link", "http://www.jfjfjfjfjfjfjfjfjfjfjfjf.com")
  end
  it 'should invalidate a link that is not a valid RSS feed' do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "link", "http://www.google.com")
  end
  it 'should invalidate if there is no link' do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "link", nil)
  end
end
