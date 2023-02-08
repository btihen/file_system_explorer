class ReturnedData
  attr_reader :state, :file_structure, :current_path
  private :file_structure, :current_path

  def initialize(state)
    @state = state
    @current_path = state[:current_path]
    @file_structure = state[:file_structure]
  end

  def update(context_data, name)
    return state if context_data.nil?

    nodes_path = ['/'] + current_path.split('/').reject { |p| p == '' }
    current_node = file_structure.dig(*nodes_path)

    case context_data
    when 'dir'
      current_node[name] = {}
    else
      current_node[name] = context_data.to_i
    end
    @state[:current_path] = current_path
    @state[:file_structure] = file_structure
    state
  end
end
