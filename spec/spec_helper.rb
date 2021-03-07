# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

require 'byebug'
require_relative '../lib/space_radar'

# For IRB
# require 'space_radar'
# board = File.open('/Users/manolistsilikidis/Downloads/board_sample.txt')
# in1 = File.open('/Users/manolistsilikidis/Downloads/si1.txt')
# in2 = File.open('/Users/manolistsilikidis/Downloads/si2.txt')

# invader1 = SpaceRadar::SpaceInvader.new in1
# invader2 = SpaceRadar::SpaceInvader.new in2
# radar = SpaceRadar::Radar.new board, target: invader1
# radar.init_lookout!
