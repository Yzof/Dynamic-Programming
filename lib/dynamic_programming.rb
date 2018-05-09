require 'set'

class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }

    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    odd = ((n - 1) * 2) - 1
    val = blair_nums(n - 2) + blair_nums(n - 1) + odd
    @blair_cache[n] = val
    val
  end

  # My version
  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
  end

  def find_permutations(arr, i, cap)
    # after testing this works
    perms = []

    0.upto(arr.length) do |idx|
      copy = arr.dup
      copy.insert(idx, i)

      if !valid_perm?(copy, cap)
        return false
      else
        perms << copy
      end
    end

    perms
  end

  def valid_perm?(arr, cap)
    # after testing this works
    sum = arr.inject(:+)
    sum == cap
  end

  def frog_cache_builder(n)
    return @frog_cache[n] if @frog_cache[n]
    base_hops = [1, 2, 3]

    # add back in the @
    prev_cases = [
      frog_cache_builder(n - 1),
      frog_cache_builder(n - 2),
      frog_cache_builder(n - 3)
    ]

    new_set = Set.new

    prev_cases.each do |prev|
      prev.each do |array|
        base_hops.each do |hop|
          perms = find_permutations(array, hop, n)

          if perms
            perms.each do |perm|
              new_set.add(perm)
            end
          else
            next
          end
        end
      end
    end

    new_arr = new_set.to_a
    @frog_cache[n] = new_arr
    new_arr
  end
  # Jon's version
  # def frog_hops_bottom_up(n)
  #
  # end
  #
  # def hopper
  #
  # end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
