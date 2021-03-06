require "spec_helper"

describe RSpec::Core::Deprecation do
  describe "#deprecate" do
    context "old API with individual args" do
      it "includes the method to deprecate" do
        expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :deprecated => "deprecated_method")
        RSpec.deprecate("deprecated_method")
      end

      it "includes the replacement when provided" do
        expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :deprecated => "deprecated_method", :replacement => "replacement")
        RSpec.deprecate("deprecated_method", "replacement")
      end

      it "adds the call site" do
        expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :call_site => caller(0)[1])
        RSpec.deprecate("deprecated_method")
      end
    end

    context "new API with a hash after the first arg" do
      it "passes the hash to the reporter" do
        expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :deprecated => "deprecated_method", :replacement => "replacement")
        RSpec.deprecate("deprecated_method", :replacement => "replacement")
      end

      it "adds the call site" do
        expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :call_site => caller(0)[1])
        RSpec.deprecate("deprecated_method")
      end
    end
  end

  describe "#warn_deprecation" do
    it "puts message in a hash" do
      expect(RSpec.configuration.reporter).to receive(:deprecation).with(hash_including :message => "this is the message")
      RSpec.warn_deprecation("this is the message")
    end
  end
end
