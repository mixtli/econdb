require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'activeresource'


module Fred
  class Base
    cattr_accessor :api_key
    class_inheritable_accessor :base_url, :primary_key, :collection_path, :element_path
    attr_reader :attributes
    self.base_url = "http://api.stlouisfed.org/fred"

    def initialize(attrs)
      @attributes = attrs
    end

    def self.get(id)
      uri = base_url + "/#{element_path}?api_key=#{api_key}&#{primary_key}=#{id}"
      RAILS_DEFAULT_LOGGER.debug uri
      doc = Hpricot.XML(open(uri))        
      new(doc.search("/*/*")[1].attributes)
    end    

    def self.find(params = {})
      results = []
      uri = base_url + "/" + collection_path + "?" + encode_params(params)
      puts uri
      doc = Hpricot.XML(open(uri))
      doc.search("/*/*").each do |el|
        results << new(el.attributes) if el.respond_to?(:attributes)
      end
      results
    end

    def self.encode_params(args)
      args['api_key'] ||= api_key
      args.map { |k,v| "%s=%s" % [URI.encode(k.to_s), URI.encode(v.to_s)] }.join('&') unless args.blank?
    end
  end

  class Category < Base
    self.collection_path = "category"
    self.element_path = "category"
    self.primary_key = "category_id"
  end
  
  class Release < Base
    self.collection_path = "releases"
    self.element_path = "release"
    self.primary_key = "release_id"
  end

  class Series < Base
    self.collection_path = "series/search"
    self.element_path = "series"
    self.primary_key = "series_id"

    def observations(params = {})
      data = []
      puts attributes.inspect
      params[:series_id] = attributes["id"]
      uri = base_url + "/series/observations?" + self.class.encode_params(params)
      puts uri
      doc = Hpricot.XML(open(uri))
      doc.search("/*/*").each do |el|
        data << el.attributes if el.respond_to?(:attributes)
      end
      data      
    end
  end
  
  class Source < Base
    self.collection_path = "sources"
    self.element_path = "source"
    self.primary_key = "source_id"
  end

end

# Example Usage:
#Fred::Base.api_key = "39e6580aa035fa02ef28ac0f5e2752b8"  
#
#puts "Category.get"
#puts Fred::Category.get(125).inspect
#
#puts "Category.find"
#puts Fred::Category.find.inspect
#
#puts "Release.get"
#puts Fred::Release.get(178).inspect
#
#puts "Release.find"
#puts Fred::Release.find.inspect
#
#puts "Series.find"
#puts Fred::Series.find(:search_text => 'money').inspect
#
#puts "Series.get"
#s = Fred::Series.get('M2ASL')
#puts s.observations.inspect
#
#
#puts "Source.find"
#puts Fred::Source.find.inspect
#
#puts "Source.get"
#puts Fred::Source.get(36).inspect
