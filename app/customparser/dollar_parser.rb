require 'date'
require 'pry'

class DollarParser

  def generate(content, key_order)
    dollar_data =[]
    dollar_content =  content.split("\n")
    dollar_header = dollar_content.shift.split("$")

    dollar_content.each do |line|
      key_value = get_key_value(key_order)
      line_content = line.split("$")
      key_value[:"#{dollar_header[0].strip}"] = line_content[0].strip
      key_value[:"#{dollar_header[1].strip}"] = line_content[1].strip
      key_value[:"#{dollar_header[2].strip}"] = line_content[2].strip
      key_value[:"#{dollar_header[3].strip}"] = line_content[3].strip
      dollar_data.push(key_value)
    end

    dollar_data.each do |line|
      line[:birthdate] = Date.strptime(line[:birthdate], "%d-%m-%Y").strftime("%-m/%-d/%Y")
      line[:city] = AbstractParser::CITIES.select { |k,v| v.include?(line[:city]) }.keys[0]
    end

  end

  def get_key_value(key_order)
    h = Hash.new
    key_order.each {|a| h[a.to_sym] = nil}
    h
  end
end