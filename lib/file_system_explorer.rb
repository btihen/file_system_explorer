# frozen_string_literal: true

require_relative './parsers/input'
require_relative './calculators/directory_sizes'

# Central class that ties together the other classes and returns results
class FileSystemExplorer
  attr_reader :input_file, :input_parser, :directory_calculator, :file_structure, :directory_sizes
  private :input_file, :input_parser, :directory_calculator

  def initialize(input_file,
                 input_parser: Parsers::Input,
                 directory_calculator: Calculators::DirectorySizes)
    @input_file = input_file
    @input_parser = input_parser
    @file_structure = {}
    @directory_calculator = directory_calculator
  end

  def run
    parse_input
    calculate_directory_sizes
  end

  def parse_input
    @input_parser = input_parser.new(input_file)
    input_parser.run
    @file_structure = input_parser.file_structure
  end

  def calculate_directory_sizes
    @directory_calculator = directory_calculator.new(file_structure)
    directory_calculator.run
    @directory_sizes = directory_calculator.directory_sizes
  end
end
