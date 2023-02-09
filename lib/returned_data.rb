# frozen_string_literal: true

# this class updates the file structure from the data returned from the various commands
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

    update_file_structure(context_data, current_node, name)

    @state[:current_path] = current_path
    @state[:file_structure] = file_structure
    state
  end

  private

  def update_file_structure(context_data, current_node, name)
    return current_node[name] = {} if context_data == 'dir'

    current_node[name] = context_data.to_i
  end
end
