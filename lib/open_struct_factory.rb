require "open_struct_factory/version"

module OpenStructFactory

  # Creates an OpenStruct from the given hash
  # * It recursively transform nested hashes into OpenStruct
  # * It recursively goes through arrays, transforming hashes into OpenStruct
  # * An optional block can be passed to process the hash keys
  def self.create(hash, &block) # :yields: key
    properties = {}
    hash.each_pair do |key, value|
      property_name = block_given? ? (yield key) : key
      properties[property_name] = process_value(value, &block)
    end
    OpenStruct.new(properties)
  end

  private

  def self.process_value(value, &block)
    case
    when value.respond_to?(:each_pair)
     create(value, &block)
    when value.is_a?(Array)
      value.map { |v| process_value(v, &block) }
    else
      value
    end
  end

end
