require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'activeresource'


module WorldBank
  class Base
    cattr_accessor :api_key
    class_inheritable_accessor :base_url, :primary_key, :collection_path, :element_path
    attr_reader :attributes
    self.base_url = "http://open.worldbank.org"
    self.api_key = "xv6r542fqbyc4t72jr9hhz96"
    def [](attr)
      attributes[attr.to_s]
    end
    
    def initialize(attrs)
      @attributes = attrs
    end

    def self.get(id)
      puts "get(id)"
      uri = base_url + "/#{collection_path}/#{id}?api_key=#{::WorldBank::Base.api_key}"
      puts uri
      doc = Hpricot.XML(open(uri))
      puts doc
      args = doc.search("/*/*/*").select { |a| a.name =~ /wb:/ }.inject({}) { | h, a| h.merge( { a.name.sub("wb:","") => a.inner_html })  }
      args['id'] = id
      new(args)
    end    

    def self.find(params = {})
      results = []
      params[:per_page] ||= 500
      uri = base_url + "/" + collection_path + "?" + encode_params(params)
      puts uri
      doc = Hpricot.XML(open(uri))
      puts doc
      doc.search("/*/*").each do |el|
        results << new(el.search("*/*").select { |a| a.name =~ /wb:/ }.inject({}) { | h, a| h.merge( { a.name.sub("wb:","") => a.inner_html })  }) if el.respond_to?(:attributes)
      end
      results
    end

    def self.encode_params(args)
      args['api_key'] ||= ::WorldBank::Base.api_key
      args.map { |k,v| "%s=%s" % [URI.encode(k.to_s), URI.encode(v.to_s)] }.join('&') unless args.blank?
    end
  end

  class Country < Base
    self.collection_path = "countries"

  end
  

  class Indicator < Base
    self.collection_path = "indicators"

    def data(country, params = {})
      data_entries = []
      uri = base_url + "/countries/#{country}/indicators/#{self[:id]}?" + self.class.encode_params(params)
      puts "URI = " + uri
      doc = Hpricot.XML(open(uri))
      puts doc
      doc.search("/*/*").each do |el|
        puts "found el #{el.inspect}"
        data_entries << {
          :date => Date.new(el.at("wb:date").inner_html.to_i),
          :value => el.at("wb:value").inner_html
        } if el.at("wb:date")
      end
      data_entries.sort_by {|e| e[:date] }
    end
  end
  
end

