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

    @super_cache = {
      1 => [[1]],
      2 => [[1,1],[2]],
      3 => [[1, 1, 1], [1, 2], [2, 1],[3]]
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
    # Base Case

    frog_hops_top_down_helper(n)

    #Inductive Step
  end

  def frog_hops_top_down_helper(n)
    # What is this for?
    #
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

  def super_frog_hops(n, k)
    return [[1]*n] if k == 1
    k = n if k > n
    return nil if n > 999
    return @super_cache[n] if @super_cache[n]
    value = []
    n.downto(2) do |idx|
      if k >= (n-idx+1)
        value += super_frog_hops(idx-1,k).map {|arr| [n-idx+1] + arr }
      end
    end
    @super_cache[n] = value
    @super_cache[n]
  end

  def condense_array(arr, num)
    arr.inject(:+) + num
  end

  def hopper(current_step, target, max_stairs)
    return "something" if current == target

    moves = (1..max_stairs).to_a

    for move in moves do
      if current_step + move < target
        for to_here in @super_cache[current_step] do
          @super_cache[current_step + move].push(to_here.push(move))
        end
      elsif current_step + move == target
        for to_here in cache[current] do
          possible.push(to_here.push(move))
        end
      end
    end
    hopper(current_step + 1, target, max_stairs)
    possible
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
