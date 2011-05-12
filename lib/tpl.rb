require 'nokogiri'

module Tpl
  
  class << self
    def render(tpl, assigns = {})
      doc = Nokogiri::HTML::DocumentFragment.parse(tpl)
      
      doc.css('*[data-tpl-content]').each do |i|
        # i['data-tpl-content'] = nil
        i.content = assigns[i['data-tpl-content'].to_sym]
        i.remove_attribute('data-tpl-content')
      end
      
      doc.css('*[data-tpl-remove]').each { |i| i.unlink }
      
      # Filters
      doc.css('*[data-tpl-filter-find]').each do |i|
        find = i['data-tpl-filter-find']
        replace = i['data-tpl-filter-replace']
        
        if find and replace
          i.content = i.content.gsub(%r{#{find}}, replace)
        end
        
        i.remove_attribute('data-tpl-filter-find')
        i.remove_attribute('data-tpl-filter-replace')
      end
      
      doc.to_html
    end
  end
end
