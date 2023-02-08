require_relative './commands.rb'
require_relative './returned_data.rb'

class InputParser
  attr_reader :input_data_file, :state
  private :input_data_file

  def initialize(input_data_file)
    @state = { current_path: '', file_structure: {} }
    @input_data_file = input_data_file
  end

  def self.call(input_data_file)
    new(input_data_file).run
  end

  def run
    read_file
    state
  end

  def file_structure
    state[:file_structure]
  end

  def current_path
    state[:current_path]
  end

  private

  # read whole file at once
  # file_data = File.read(data_path).split
  def read_file
    # process one line at a time
    File.foreach(input_data_file) { |line| parse(line) }
  end

  def parse(line)
    if line.start_with?('$')
      process_command(line)
    else
      process_returned_data(line)
    end
  end

  def process_command(line)
    prompt, command, args = line.split
    klass = Object.const_get("Command#{command.capitalize}")

    @state = klass.new(state).update(args)
  end

  def process_returned_data(line)
    context_data, name = line.split

    @state = ReturnedData.new(state).update(context_data, name)
  end
end
