module Som
  class Neuron
    attr_accessor :weights, :x, :y

    def initialize(x, y)
      @weights = []
      @x = x
      @y = y
    end
  end
end
