#!/usr/bin/ruby
require 'rubygems'
require 'rexml/document'
require 'open-uri'
require 'fusion_specs'

module Fusion
  def self.get_country_specs
    uri = "http://www.fusioncharts.com/maps/docs/Contents/MapSS/WorldwithCountriesMap.html"
    doc = REXML::Document.new(open(uri))



    countries = {}
    doc.root.each_element("//tr") do |el|
      countries[el.children[1].text] = {:shortname => el.children[3].text, :longname => el.children[5].text }
    end
    countries
  end


   def self.save_country_specs
     countries = get_country_specs
     output = <<-EOF
       module Fusion
         COUNTRIES = #{countries.inspect}
       end
     EOF
     File.open(RAILS_ROOT + "/lib/fusion_specs.rb", "w+").write(output)
   end

   def self.country_id_by_code(code)
     Fusion::COUNTRIES.find {|i, c| c[:shortname] == code }.first rescue nil
   end

end
