def neighbors_of(cell)
  [[-1,-1], [-1,0], [-1,1],
   [ 0,-1],         [ 0,1],
   [ 1,-1], [ 1,0], [ 1,1]].map { |offset| [offset[0] + cell[0], offset[1] + cell[1]] }
end

class Grid
  attr_reader :live_cells

  def initialize(live_cells)
    @live_cells = live_cells.uniq
  end

  def next_gen
    surviving(live_cells) + vivifying(dead(neighbors_of_all(live_cells)))
  end

  def neighbors_of_all(cells)
    cells.flat_map { |cell| neighbors_of(cell) }.uniq
  end

  def vivifying(cells)
    cells.select { |cell| vivifying?(cell) }
  end

  def vivifying?(cell)
    live(neighbors_of(cell)).count == 3 
  end

  def dead(cells)
    cells.reject { |cell| alive?(cell) }
  end

  def surviving(cells)
    cells.select { |cell| surviving?(cell) }
  end

  def surviving?(cell)
    [2, 3].include?(live(neighbors_of(cell)).count)
  end

  def live(cells)
    cells.select { |cell| alive?(cell) }
  end

  def alive?(cell)
    live_cells.include?(cell)
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

  def next_gen(live_cells)
    Grid.new(live_cells).next_gen
  end
end

describe "neighbors of cell" do
  it "[0,0] should be [-1,-1], [-1,0], [-1,1], [ 0,-1], [ 0,1], [ 1,-1], [ 1,0], [ 1,1] in any order" do
    cell = [0,0]
    neighbors_of(cell).should =~ [[-1,-1], [-1,0], [-1,1],
                                  [ 0,-1],         [ 0,1],
                                  [ 1,-1], [ 1,0], [ 1,1]]
  end

  it "[1,2] should be [0,1], [0,2], [0,3], [1,1], [1,3], [2,1], [2,2], [2,3] in any order" do
    cell = [1,2]
    neighbors_of(cell).should =~ [[0,1], [0,2], [0,3],
                                  [1,1],        [1,3],
                                  [2,1], [2,2], [2,3]]
  end
end
