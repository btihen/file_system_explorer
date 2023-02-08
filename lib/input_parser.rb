class InputParser
  attr_reader :data_path, :file_structure, :current_path, :last_command
  # private     :file_path

  def initialize(data_path)
    @file_structure = {}
    @data_path = data_path
    @current_path = ''
  end

  def self.call(data_path)
    new(data_path).run
  end

  def run
    read_file
  end

  private

  # read whole file at once
  # file_data = File.read(data_path).split
  def read_file
    # process one line at a time
    File.foreach(data_path) { |line| parse(line) }
  end

  def parse(line)
    if line.start_with?('$')
      prompt, command, args = line.split

      case command
      when 'cd'
        case args
        when '/'
          @current_path = '/'
          file_structure['/'] = {}
        when '..'
          path_elements = @current_path.split('/').reject { |p| p == '' }
          @current_path = '/' + path_elements.take(path_elements.size - 1).join('/')
        else
          nodes_path = ['/'] + @current_path.split('/').reject { |p| p == '' }
          current_node = file_structure.dig(*nodes_path)
          current_node[args] = {}
          @current_path = '/' + (@current_path.split('/').reject { |p| p == '' } + [args]).join('/')
        end
      when 'ls'
      end

    # when returned data
    else
      context_info, name = line.split
      nodes_path = ['/'] + @current_path.split('/').reject { |p| p == '' }
      current_node = file_structure.dig(*nodes_path)

      case context_info
      when NilClass
      when 'dir'
        current_node[name] = {}
      else
        current_node[name] = context_info.to_i
      end
    end
  end
end