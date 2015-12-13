module Som
  class Map
    def initialize(size, dimension, iterations)
      @lattice = []
      @current_it = 0
      @iterations = iterations
      @dimension = dimension
      @map_size = size
      @start_learning_rate = 0.1
    end

    def initialize_map
      for i in (0..@map_size - 1)
        row = []
        for j in (0..@map_size - 1)
          neuron = Neuron.new(i, j)
          neuron.weights = (0..@dimension - 1).collect { rand }
          row << neuron
        end
        @lattice << row
      end
      puts "Lattice size: #{@lattice.length}"
    end

    def train
      initialize_map

      movie_ids = Movie.limit(1000).pluck(:movie_id)
      while @current_it < @iterations
        puts "Iteration: #{@current_it}"
        movie_ids.each do |id|
          example = MovieTag.where('movie_id = ?', id).pluck(:relevance)
          raise "This is wrong" unless example.length == 1128
          winner = find_winner(example)
          raise "The winner is not right" unless winner.weights.length == 1128
          adjust_neighbors(example, winner)
        end
        @current_it += 1
      end
    end

    def find_winner(example_weights)
      min = Float::MAX
      winner = nil
      @lattice.each do |row|
        row.each do |element|
          d = distance(example_weights, element.weights)
          if d < min
            min = d
            winner = element
          end
        end
      end
      winner
    end

    private

    def distance(example_weights, neuron_weights)
      sum = 0
      example_weights.zip(neuron_weights).each do |x, y|
        sum += (x - y)**2
      end
      Math.sqrt(sum)
    end

    def adjust_neighbors(example, winner)
      @lattice.each do |row|
        row.each do |element|
          i = influence(element, winner)
          element.weights.zip(example) do |neuron_weight, example_weight|
            puts "Old weight: #{neuron_weight}"
            puts "Example weight: #{example_weight}"
            neuron_weight = adjust_weight(neuron_weight, example_weight, i)
            puts "New weight: #{neuron_weight}"
          end
        end
      end
    end

    def adjust_weight(neuron_weight, example_weight, influence)
      neuron_weight + learning_rate * influence * (neuron_weight - example_weight)
    end

    def neighborhood_radius
      time_constant = @iterations / Math.log(@map_size)
      @map_size * Math.exp(-@current_it / time_constant)
    end

    def learning_rate
      Math.exp(-@current_it.to_f / @iterations.to_f) * @start_learning_rate
    end

    def influence(node, winner)
      d = Math.sqrt((node.x - winner.x)**2 + (node.y - winner.y)**2)
      Math.exp(-(d**2) / neighborhood_radius**2)
    end
  end
end
