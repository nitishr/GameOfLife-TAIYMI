describe "In the next gen, a grid with" do
  [[], [[0,0]], [[0,0], [0,1]]].each do |cells|
    context "#{cells.size} live cells" do
      it "should have no live cells" do
        g = cells
        ng = next_gen(g)
        ng.should == []
      end
    end
  end

  context "3 live cells in a diagonal" do
    it "should have only the middle cell alive" do
      g = [[0,0],
                  [1,1],
                         [2,2]]
      ng = next_gen(g)
      pending "calculation of neighbors"
      ng.should == [[1,1]]
    end
  end

  def next_gen(grid)
    []
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

  def neighbors_of(location)
    [[-1,-1], [-1,0], [-1,1],
     [ 0,-1],         [ 0,1],
     [ 1,-1], [ 1,0], [ 1,1]].map { |offset| [offset[0] + location[0], offset[1] + location[1]] }
  end
end
