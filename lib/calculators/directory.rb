# frozen_string_literal: true

# class that takes a file structure and calculates the sizes of each directory
module Calculators
  class Directory
    attr_reader :file_structure, :directory_sizes
    private :file_structure

    def initialize(file_structure)
      @file_structure = file_structure
      @directory_sizes = file_structure
    end

    def run
      @paths = all_unique_paths(file_structure)
    end

    private

    def all_unique_paths(hash)
      edge_paths(hash).flat_map do |edge|
        list = ['/'] + edge.split('/').reject { |p| p == '' }
        (0..list.size - 1).map { |i| list[0..i].join('/').gsub('//', '/') }
      end.uniq
    end

    # adapted from: https://stackoverflow.com/questions/59495005/build-paths-of-edge-keys-in-nested-hashes-in-ruby
    def edge_paths(hash)
      hash.flat_map do |key, value|
        if value.is_a?(Integer)
          ''
        elsif !value.is_a?(Hash) || value.empty?
          key.to_s
        else
          edge_paths(value).map { |path| "#{key}/#{path}" }
        end
      end
    end
  end
end
