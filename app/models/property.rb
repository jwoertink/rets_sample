class Property
  
  def initialize(auth_hash)
    @client = RETS::Client.login(auth_hash)
  end
  
  def search(params = {}, &block)
    # Find only active properties
    params.merge!("242" => "ER,EA,C", "1809" => "Y", "130" => "Y")
    filter = hash_to_rets_str(params)
    
    @client.search(:search_type => :Property, :class => "1", :query => filter, &block)
  end
  
  def get_object
    @client.get_object(:resource => :Property, :type => :Photo, :location => false, :id => "1:0:*") do |object|
      puts "Object-ID #{object[:headers]['Object-ID']}, Content-ID #{object[:headers]['Content-ID']}, Description #{object[:headers]['Description']}"
      puts "Data"
      puts object[:content]
    end
  end
  
  private
  
    def hash_to_rets_str(hash)
      str = []
      hash.each_pair do |k,v|
        str << "(#{k.to_s.camelize}=#{v})"
      end
      str.join(',')
    end
  
end