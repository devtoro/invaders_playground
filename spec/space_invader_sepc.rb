# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/space_radar/space_invader'

RSpec.describe SpaceRadar::SpaceInvader, 'Test initialisation and mainfunctionality of SpaceInvader class' do
  context 'Init input validation' do
    it 'Raises Argument error if init argument empty or invalid(not String or not File)' do
      expect { SpaceRadar::SpaceInvader.new }.to raise_error(ArgumentError)
      expect { SpaceRadar::SpaceInvader.new(1) }.to raise_error(ArgumentError)
    end

    it 'Raises RuntimeError if string is not a path to a file' do
      expect { SpaceRadar::SpaceInvader.new('sample').to raise_error(RuntimeError) }
    end
  end
end
