require 'test_helper'
require 'generators/multimedia/multimedia_generator'

class MultimediaGeneratorTest < Rails::Generators::TestCase
  tests MultimediaGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
