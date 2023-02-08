class CommandLs
  attr_reader :state

  def initialize(state)
    @state = state
  end

  def update(args = nil)
    state
  end
end

class CommandCd
  attr_reader :state, :file_structure, :current_path
  private :file_structure, :current_path

  def initialize(state)
    @state = state
    @current_path = state[:current_path]
    @file_structure = state[:file_structure]
  end

  def update(args)
    case args
    when '/'
      @current_path = '/'
      @file_structure['/'] = {}
    when '..'
      path_elements = current_path.split('/').reject { |p| p == '' }
      @current_path = '/' + path_elements.take(path_elements.size - 1).join('/')
    else
      nodes_path = ['/'] + @current_path.split('/').reject { |p| p == '' }
      current_node = file_structure.dig(*nodes_path)
      current_node[args] = {}
      @current_path = '/' + (@current_path.split('/').reject { |p| p == '' } + [args]).join('/')
    end
    @state[:current_path] = current_path
    @state[:file_structure] = file_structure
    state
  end
end
