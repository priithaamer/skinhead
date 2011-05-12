require 'spec_helper'
require 'benchmark'

describe Tpl do
  describe 'data-tpl-content' do
    it 'should work' do
      tpl = <<-EOF
      <div data-tpl-content="body">Default content</div>
      EOF
      
      # time = Benchmark.measure do
      #   Tpl.render(doc, {:body => 'Test body'}).strip.should == '<div>Test body</div>'
      # end
      # puts time
      
      Tpl.render(tpl, {:body => 'Test body'}).strip.should == '<div>Test body</div>'
    end
  end
  
  describe 'data-tpl-remove' do
    it 'removes element entirely' do
      tpl = <<-EOF
        <div>This will stay</div>
        <div data-tpl-remove="true">This will go</div>
      EOF
      
      Tpl.render(tpl).strip.should == '<div>This will stay</div>'
    end
  end
  
  describe 'data-tpl-capture' do
    it 'captures the contents of element'
    
    it 'assigns the captured content to variable given in attribute value'
  end
  
  describe 'filters' do
    describe 'find-replace' do
      it 'finds the value of data-tpl-filter-find and replaces it with data-tpl-filter-replace value' do
        tpl = <<-EOF
          <div data-tpl-filter-find="Foo" data-tpl-filter-replace="Bar">Foo baz</div>
        EOF
        
        Tpl.render(tpl).strip.should == '<div>Bar baz</div>'
      end
    end
  end
end