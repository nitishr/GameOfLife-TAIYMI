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

describe "a location's neighbors" do
  it "should be all locations offset by a single row and/or column" do
    location = [0,0]
    neighbors_of(location).should =~ [[-1,-1], [-1,0], [-1,1],
                                      [ 0,-1],         [ 0,1],
                                      [ 1,-1], [ 1,0], [ 1,1]]
  end

  def neighbors_of(location)
    [[-1,-1], [-1,0], [-1,1],
     [ 0,-1],         [ 0,1],
     [ 1,-1], [ 1,0], [ 1,1]]
  end
end
