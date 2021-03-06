require "spec_helper"

describe OpenStructFactory do

  describe ".create" do

    context "when given a simple hash" do

      let(:hash) do
        {:foo => "bar", "baz" => 123}
      end

      it "creates an OpenStruct" do
        os = OpenStructFactory.create(hash)
        expect(os.foo).to eq("bar")
        expect(os.baz).to eq(123)
      end

    end

    context "when given a hash with a single level of nesting" do

      let(:hash) do
        {
          :foo => "bar",
          :baz => 123,
          "nested" => {
            :qux => true,
          }
        }
      end

      it "creates a nested OpenStruct" do
        os = OpenStructFactory.create(hash)
        expect(os.foo).to eq("bar")
        expect(os.baz).to eq(123)
        expect(os.nested.qux).to eq(true)
      end

    end

    context "when given a hash with several levels of nesting" do

      let(:hash) do
        {
          :foo => {
            :bar => {
              "baz" => {
                :qux => true
              }
            }
          }
        }
      end

      it "creates a nested OpenStruct" do
        os = OpenStructFactory.create(hash)
        expect(os.foo.bar.baz.qux).to eq(true)
      end

    end

    context "when given a hash containing an array of non-aggregates" do

      let(:hash) do
        {:foo => "bar", :baz => [1, 2, "three"]}
      end

      it "creates an OpenStruct" do
        os = OpenStructFactory.create(hash)
        expect(os.foo).to eq("bar")
        expect(os.baz).to eq([1, 2, "three"])
      end

    end

    context "when given a hash containing an array of hashes" do

      let(:hash) do
        {
          :foo => [
            {:bar => 1},
            {:baz => {:qux => true}},
          ]
        }
      end

      it "creates a nested OpenStruct" do
        os = OpenStructFactory.create(hash)
        expect(os.foo[0].bar).to eq(1)
        expect(os.foo[1].baz.qux).to eq(true)
      end

    end

    context "when given an non-Hash object responding to each_pair" do

      class ActionControllerParameters

        def initialize(bar, baz)
          @bar = bar
          @baz = baz
        end

        def each_pair(&block)
          [[:bar, @bar], [:baz, @baz]].each(&block)
        end

      end

      let(:hash) do
        {
          :foo => ActionControllerParameters.new(123, ActionControllerParameters.new("abc", "xyz")),
        }
      end

      it "treats it like a hash" do
        os = OpenStructFactory.create(hash)
        expect(os.foo.bar).to eq(123)
        expect(os.foo.baz.bar).to eq("abc")
        expect(os.foo.baz.baz).to eq("xyz")
      end
    end

    context "when given a block" do

      let(:hash) do
        {
          "FOO" => 123,
          "Bar" => {
            "BAZ" => {
              "qux" => true
            }
          }
        }
      end

      it "creates a nested OpenStruct with property names processed by the given block" do
        os = OpenStructFactory.create(hash) { |property_name| property_name.downcase }
        expect(os.foo).to eq(123)
        expect(os.bar.baz.qux).to eq(true)
      end
    end

  end # .create

end
