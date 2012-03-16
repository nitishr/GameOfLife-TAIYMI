def neighbors_of(location)
  [[-1,-1], [-1,0], [-1,1],
   [ 0,-1],         [ 0,1],
   [ 1,-1], [ 1,0], [ 1,1]].map { |offset| [offset[0] + location[0], offset[1] + location[1]] }
end

class Grid
  attr_reader :live_locations

  def initialize(live_locations)
    @live_locations = live_locations.uniq
  end

  def next_gen
    surviving(live_locations) + vivifying(dead(neighbors_of_all(live_locations)))
  end

  def neighbors_of_all(locations)
    locations.flat_map { |location| neighbors_of(location) }.uniq
  end

  def vivifying(locations)
    locations.select { |location| vivifying?(location) }
  end

  def vivifying?(location)
    live(neighbors_of(location)).count == 3 
  end

  def dead(locations)
    locations.reject { |location| alive?(location) }
  end

  def surviving(locations)
    locations.select { |location| surviving?(location) }
  end

  def surviving?(location)
    [2, 3].include?(live(neighbors_of(location)).count)
  end

  def live(locations)
    locations.select { |location| alive?(location) }
  end

  def alive?(location)
    live_locations.include?(location)
  end
end

describe "In the next gen, a grid with" do
  [[], [[0,0]], [[0,0], [0,1]]].each do |g|
    context "#{g.size} live cells" do
      it "should have no live cells" do
        next_gen(g).should =~ []
      end
    end
  end

  context "3 live cells in a diagonal" do
    it "should have only the middle cell alive" do
      g = [[0,0],
                  [1,1],
                         [2,2]]
      next_gen(g).should =~ [[1,1]]
    end
  end

  context "4 live cells in a square block" do
    it "should remain unchanged" do
      g = [[0,0], [0,1],
           [1,0], [1,1]]
      next_gen(g).should =~ g
    end
  end

  context "3 live cells in a row" do
    it "should have instead 3 live cells in a column, with the middle cell unchanged" do
      g = [[0,0], [0,1], [0,2]]
      next_gen(g).should =~ [[-1,1], [0,1], [1,1]]
    end
  end

  context "5 live cells forming a +" do
    it "should have instead 8 live cells forming a hollow square" do
      g = [        [-1,0],
           [0,-1], [ 0,0], [0,1],
                   [ 1,0]        ]
      next_gen(g).should =~ [[-1,-1], [-1,0], [-1,1],
                             [ 0,-1],         [ 0,1],
                             [ 1,-1], [ 1,0], [ 1,1]]
    end
  end

  context "8 live cells forming a hollow square" do
    it "should have instead 8 live cells forming a diamond" do
      g = [[-1,-1], [-1,0], [-1,1],
           [ 0,-1],         [ 0,1],
           [ 1,-1], [ 1,0], [ 1,1]]
      next_gen(g).should =~ [                 [-2,0],
                                     [-1,-1],        [-1,1],
                             [0,-2],                         [0,2],
                                     [ 1,-1],        [ 1,1],
                                              [ 2,0]              ]
    end
  end

  def next_gen(live_locations)
    Grid.new(live_locations).next_gen
  end
end

describe "neighbors of location" do
  it "[0,0] should be [-1,-1], [-1,0], [-1,1], [ 0,-1], [ 0,1], [ 1,-1], [ 1,0], [ 1,1] in any order" do
    location = [0,0]
    neighbors_of(location).should =~ [[-1,-1], [-1,0], [-1,1],
                                      [ 0,-1],         [ 0,1],
                                      [ 1,-1], [ 1,0], [ 1,1]]
  end

  it "[1,2] should be [0,1], [0,2], [0,3], [1,1], [1,3], [2,1], [2,2], [2,3] in any order" do
    location = [1,2]
    neighbors_of(location).should =~ [[0,1], [0,2], [0,3],
                                      [1,1],        [1,3],
                                      [2,1], [2,2], [2,3]]
  end
end
