# frozen_string_literal: true

require_relative '../../lib/calculators/directory_paths'

module Calculators
  # class that takes a file structure and calculates the sizes of each directory
  class DirectorySizes
    attr_reader :file_structure, :paths_calculator, :paths, :directory_sizes
    private :file_structure, :paths_calculator

    def initialize(file_structure, paths_calculator: Calculators::DirectoryPaths)
      @paths_calculator = paths_calculator.new(file_structure)
      @file_structure = file_structure
      @directory_sizes = []
      @paths = []
    end

    def run
      paths_calculator.run
      @paths = paths_calculator.paths
      @directory_sizes = compute_directory_sizes
    end

    private

    def compute_directory_sizes
      paths.each do |sub_path|
        @directory_sizes << { sub_path => directory_size(sub_path) }
      end
      directory_sizes.flatten
    end

    def directory_size(sub_path_string)
      sub_file_structure = {}
      sub_path_list = ['/'] + sub_path_string.split('/').reject { |p| p == '' }
      sub_file_structure[sub_path_string] = file_structure.dig(*sub_path_list)
      @path_sum = 0 # reset path_sum for each sub_path (DANGER: this is a instance variable - solution for recursion)
      sum_file_values(sub_file_structure)
      @path_sum
    end

    # adapted from: https://stackoverflow.com/questions/9279768/how-do-i-loop-over-a-hash-of-hashes
    # cannot set @path_sum locally since this is recursive
    def sum_file_values(file_hash)
      file_hash.each_pair do |_key, value|
        if value.is_a?(Hash)
          sum_file_values(value)
        else
          @path_sum += value.to_i
        end
      end
    end
  end
end
