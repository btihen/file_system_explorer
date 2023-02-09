# frozen_string_literal: true

require_relative './parsers/input'
require_relative './calculators/directory'

# Central class that ties together the other classes and returns results
class FileSystemExplorer
  attr_reader :input_parser, :directory_calculator, :file_structure, :directory_sizes
  private :input_parser, :directory_calculator

  def initialize(input_data_file, input_parser: Parsers::Input, directory_calculator: Calculators::Directory)
    @file_structure = { '/' => {} }
    @input_parser = input_parser.new(input_data_file)
    @directory_calculator = directory_calculator
  end

  def run
    parse_input
  end

  def parse_input
    input_parser.run
    @file_structure = input_parser.file_structure
  end

  # def calculate_directories
  #   @directory_sizes = directory_calculator.new(file_structure)
  #                                          .run.directory_sizes
  # end
end
