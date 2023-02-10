# frozen_string_literal: true

require_relative './lib/file_system_explorer'

assignment_file = ARGV[0] || 'data/input.txt'

explorer = FileSystemExplorer.new(assignment_file)

explorer.run

directory_sizes = explorer.directory_sizes

small_directories = directory_sizes.select { |dir| dir.values.first <= 100_000 }

puts 'Small directories (size <= 100K):'
puts '| Size | Path |'
puts '|------|------|'
small_directories.each do |(dir)|
  path = dir.keys.first
  size = dir.values.first
  puts "| #{size} | #{path} |"
end
small_dir_size = small_directories.sum { |dir| dir.values.first }
puts "| #{small_dir_size} | Total size of small directories |"
