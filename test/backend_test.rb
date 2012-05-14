require "test_helper"

module DeviseAsync
  describe "Backend" do
    it "gives resque as the backend" do
      Backend.for(:resque).must_equal Backend::Resque
    end

    it "gives sidekiq as the backend" do
      skip
    end

    it "gives delayed job as the backend" do
      skip
    end

    it "alerts about unsupported backend" do
      assert_raises ArgumentError do
        Backend.for(:unsupported_backend)
      end
    end
  end
end
