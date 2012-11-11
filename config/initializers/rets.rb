# Need this until it's pulled into Rails master
class Hash
  def recursive_symbolize_keys!
    symbolize_keys!
    # symbolize each hash in .values
    values.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    # symbolize each hash inside an array in .values
    values.select{|v| v.is_a?(Array) }.flatten.each{|h| h.recursive_symbolize_keys! if h.is_a?(Hash) }
    self
  end
end

RETS_CONFIG = YAML.load_file(File.join(Rails.root, 'config', 'rets_config.yml')).recursive_symbolize_keys!