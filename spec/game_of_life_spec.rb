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

  def next_gen(grid)
    []
  end
end
