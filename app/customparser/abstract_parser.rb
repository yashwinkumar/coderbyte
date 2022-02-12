require './app/customparser/dollar_parser'
require './app/customparser/percent_parser'
class AbstractParser

  attr_accessor :keys_to_return

  CITIES =
    {
      "Los Angeles": ["LA"],
      "New York City": ["New York City", "NYC"],
      "Atlanta": ["Atlanta"]
    }

  def key_order
    %w[first_name last_name city birthdate]
  end

  def sort(parse1, parse2, sort_by, keys_to_return)
    self.keys_to_return = keys_to_return
    get_sorted_by(parser(parse1),parser(parse2), sort_by)
  end

  def parser(parse)
    if parse.include?("$")
      DollarParser.new.generate(parse, key_order)
    elsif parse.include?("%")
      PercentParser.new.generate(parse, key_order)
    end
  end

  def get_sorted_by(percent_data,dollar_data,sort_by)
    content = percent_data + dollar_data
    content = content.sort do |a,b|
      a[:"#{sort_by}"].split("")[0] <=> b[:"#{sort_by}"].split("")[0]
    end
    content.map do |c|
      {}.tap do |new_hash|
        keys_to_return.each do |key|
          new_hash[key.to_sym] = c[key.to_sym]
        end
      end
    end.map { |c| c.values.join(", ")}
  end
end