require 'pry'
require './app/customparser/abstract_parser'

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    parser = AbstractParser.new
    parser.sort(@params[:dollar_format], @params[:percent_format], @params[:order], %w[first_name city birthdate])
  end

  private

  attr_reader :params
end
