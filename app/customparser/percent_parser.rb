require 'date'

class PercentParser
  def generate(content, key_order)
    percent_data =[]
    percent_content =  content.split("\n")
    percent_header = percent_content.shift.split("%")

    percent_content.each do |line|
      key_value = get_key_value(key_order)
      line_content = line.split("%")
      key_value[:"#{percent_header[0].strip}"] = line_content[0].strip
      key_value[:"#{percent_header[1].strip}"] = line_content[1].strip
      key_value[:"#{percent_header[2].strip}"] = line_content[2].strip
      key_value[:"#{percent_header[3].strip}"] = line_content[3].strip
      percent_data.push(key_value)
    end

    filter_data(percent_data)
  end

  def filter_data(percent_data)
    percent_data.each do |line|
      line[:birthdate] = Date.strptime(line[:birthdate], "%Y-%m-%d").strftime("%-m/%-d/%Y")
      line[:city] = AbstractParser::CITIES.select { |k,v| v.include?(line[:city]) }.keys[0]
    end
  end

  def get_key_value(key_order)
    h = Hash.new
    key_order.each {|a| h[a.to_sym] = nil}
    h
  end

end