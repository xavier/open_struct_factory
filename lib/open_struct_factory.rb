require "open_struct_factory/version"

module OpenStructFactory

  def self.create(hash, &block)
    properties = {}
    hash.each do |key, value|
      property_name = block_given? ? (yield key) : key
      properties[property_name] = process_value(value, &block)
    end
    OpenStruct.new(properties)
  end

  private

  def self.process_value(value, &block)
    case value
    when Hash
     create(value, &block)
    when Array
      value.map { |v| process_value(v, &block) }
    else
       value
    end
  end

end
