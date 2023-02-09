# frozen_string_literal: true

# classes that takes commands as input and updates our state - current location and file structure
module Parsers
  # this class is used to update the state when the command is 'ls'
  # it just returns the current state and makes no changes
  class CommandLs
    attr_reader :state

    def initialize(state)
      @state = state
    end

    def update(_args = nil)
      state
    end
  end

  # this class is used to update the state when the command is 'cd'
  # it updates the current path and ensures this new location exists in the file structure
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
      when '/' then cd_root_path_update
      when '..' then cd_parent_directory_update
      else
        cd_named_directory_update(args)
      end
      @state[:current_path] = current_path
      @state[:file_structure] = file_structure
      state
    end

    private

    def cd_root_path_update
      @current_path = '/'
      @file_structure['/'] = {} unless file_structure.key?('/')
    end

    def cd_parent_directory_update
      path_elements = current_path.split('/').reject { |p| p == '' }
      @current_path = "/#{path_elements.take(path_elements.size - 1).join('/')}"
    end

    def cd_named_directory_update(args)
      nodes_path = ['/'] + current_path.split('/').reject { |p| p == '' }
      current_node = file_structure.dig(*nodes_path)
      current_node[args] = {} unless current_node.key?(args)
      @current_path = "/#{(current_path.split('/').reject { |p| p == '' } + [args]).join('/')}"
    end
  end
end
