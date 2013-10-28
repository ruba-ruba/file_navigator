require 'rubygems'
require 'rspec'
require "stringio"
load File.dirname(__FILE__) + '/req.rb'

describe "test for tree" do
  it 'should display tree' do
    example = {
      'h1' => {
        'h2' => ['h3']
      }
    }
    tree(example).should eq(['h1', 'h1/h2', 'h1/h2/h3'])
  end
end