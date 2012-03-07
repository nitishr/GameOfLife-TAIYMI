describe "In the next gen, a grid with" do
  context "no live cells" do
    it "should have no live cells" do
      g = []
      ng = g
      ng.should == g
    end
  end
end
