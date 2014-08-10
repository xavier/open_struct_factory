require "open_struct_factory/version"

module OpenStructFactory

  def self.create(hash)
    properties = {}
    hash.each do |key, value|
      properties[key] = process_value(value)
    end
    OpenStruct.new(properties)
  end

  private

  def self.process_value(value)
    case value
    when Hash
     create(value)
    when Array
      value.map { |v| process_value(v) }
    else
       value
    end
  end

end
