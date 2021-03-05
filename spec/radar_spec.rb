# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SpaceRadar::Radar, 'Test initialisation and mainfunctionality of Radar class' do
  context 'Attributes' do
    let(:radar) { SpaceRadar::Radar.new("#{File.dirname(__FILE__)}/sample_files/board_sample.txt") }

    it 'has attr_reader the attribute :found_invaders' do
      expect(radar.found_invaders == 0).to be_truthy
      expect { radar.found_invaders = 10 }.to  raise_error(NoMethodError)
    end

    it 'has attr_writer attribute :noise_threshold' do
      expect(radar.noise_threshold == 1).to be_truthy
      expect(radar.respond_to?(:noise_threshold=)).to be_truthy

      radar.noise_threshold = 2
      expect(radar.noise_threshold == 2).to be_truthy
    end
  end
end
