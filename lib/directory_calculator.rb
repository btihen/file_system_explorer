# frozen_string_literal: true

# class that takes a file structure and calculates the sizes of each directory
class DirectoryCalculator
  attr_reader :file_structure, :directory_sizes
  private :file_structure

  def initialize(file_structure)
    @file_structure = file_structure
    @directory_sizes = file_structure
  end

  def run; end
end
