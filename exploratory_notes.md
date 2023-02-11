


    # # adapted from: https://stackoverflow.com/questions/9279768/how-do-i-loop-over-a-hash-of-hashes
    # # cannot set @path_sum locally since this is recursive
    # def sum_file_values(file_hash)
    #   file_hash.each_pair do |_key, val|
    #     if val.is_a?(Hash)
    #       sum_file_values(val)
    #     else
    #       @path_sum += val.to_i
    #     end
    #   end
    #   @path_sum
    # end

    # # Calculates the directory size of a nested hash by summing all the file sizes (integers in the hash)
    # # adapted from https://stackoverflow.com/questions/27979172/how-to-sum-all-deeply-nested-values-in-a-hash
    # def sum_directory_files(path_hash)
    #   path_hash.values.reject(&:empty?).flat_map(&:values)
    #            .reject { |v| v == {} }.map(&:to_i).inject(:+) || 0
    # end

    # # adapted from: https://stackoverflow.com/questions/59495005/build-paths-of-edge-keys-in-nested-hashes-in-ruby
    # def edge_values(hash)
    #   hash.flat_map do |key, value|
    #     if value.is_a?(Integer)
    #       ''
    #     elsif !value.is_a?(Hash) || value.empty?
    #       key.to_s
    #     else
    #       edge_paths(value).map { |path| "#{key}/#{path}" }
    #     end
    #   end
    # end

    # # NOT NEEDED:
    # # h = {a: {m: {b: 2, c:1}, d: {e: {f: nil}, g: 3}}}
    # # edge_paths(h)
    # # #=> ["a.m.b", "a.m.c", "a.d.e.f", "a.d.g"]
    # # h = {a: {m: {b: 2, c:1}, d: 5 }, e: {f: {g: nil}, h: 3}}
    # # edge_paths(h)
    # # #=> ["a.m.b", "a.m.c", "a.d", "e.f.g", "e.h"]
    # # sub_paths = (0..list.size-1).map { |i| list[0..i].join('.') }

    # # all_paths = ep.flat_map { |edge| list = edge.split('.'); (0..list.size-1).map { |i| list[0..i].join('.') } }.uniq
    # # # => ["a", "a.m", "a.m.b", "a.m.c", "a.d", "e", "e.f", "e.f.g", "e.h"]

    # # all_paths = ep.flat_map do |edge|
    # #               list = edge.split('.')
    # #               (0..list.size-1).map { |i| list[0..i].join('.') }
    # #             end.uniq.sort_by {|content| content.length}.reverse
    # # # ["a.m.c", "e.f.g", "a.m.b", "e.f", "a.m", "e.h", "a.d", "a", "e"]

    # # # https://apidock.com/rails/v6.0.0/Hash/deep_transform_values
    # # # https://www.rubydoc.info/gems/activesupport/Hash#deep_transform_values-instance_method

    # # # https://stackoverflow.com/questions/8748475/iterate-over-a-deeply-nested-level-of-hashes-in-ruby?rq=1
    # # def deep_traverse(hash, &block)
    # #   stack = hash.map { |k, v| [[k], v] }

    # #   until stack.empty?
    # #     key, value = stack.pop
    # #     yield(key, value)

    # #     value.each { |k, v| stack.push [key.dup << k, v] } if value.is_a? Hash
    # #   end
    # # end

    # # # https://stackoverflow.com/questions/9279768/how-do-i-loop-over-a-hash-of-hashes
    # def ihash(h, sum = 0)
    #   h.each_pair do |k, v|
    #     if v.is_a?(Hash)
    #       puts "key: #{k} recursing..."
    #       ihash(v)
    #     else
    #       # MODIFY HERE! Look for what you want to find in the hash here
    #       puts "key: #{k} value: #{v} - sum: #{sum}"
    #       sum += v.to_i
    #     end
    #   end
    #   puts "Final: #{sum}"
    #   return sum
    # end

    # # https://stackoverflow.com/questions/16412013/iterate-nested-hash-that-contains-hash-and-or-array
    # def i2hash(h)
    #   h.each_pair do |k, v|
    #     if v.is_a?(Hash) || v.is_a?(Array)
    #       puts "key: #{k} recursing..."
    #       ihash(v)
    #     else
    #       # MODIFY HERE! Look for what you want to find in the hash here
    #       puts "key: #{k} value: #{v}"
    #     end
    #   end
    # end

    # # https://stackoverflow.com/questions/65864615/how-to-iterate-over-deep-nested-hash-without-known-depth-in-ruby
    # def recurse(hash)
    #   hash.transform_values do |v|
    #     case v
    #     when String
    #       v.reverse # Just for the sake of the example
    #     when Hash
    #       recurse(v)
    #     else
    #       v
    #     end
    #   end
    # end
