describe "In the next gen, a grid with" do
  context "no live cells" do
    it "should have no live cells" do
      g = []
      ng = next_gen(g)
      ng.should == []
    end
  end

  context "one live cell" do
    it "should have no live cells" do
      g = [[0,0]]
      ng = next_gen(g)
      ng.should == []
    end
  end

  def next_gen(grid)
    []
  end
end
