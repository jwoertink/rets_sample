class Property
  
  def initialize(auth_hash)
    @client = RETS::Client.login(auth_hash)
  end
  
  def search(params = {}, &block)
    filter = hash_to_str(params)
    # class is some kind of number...
    # "11", "1", "4", "5", "6", "7", "8", "9", "12", "14", "16"
    @client.search(:search_type => :Property, :class => "1", :query => filter, &block)
  end
  
  private
  
    def hash_to_str(hash)
      str = ""
      hash.each_pair do |k,v|
        str << "(#{k.to_s.camelize}=#{v})"
      end
      str
    end
  
end