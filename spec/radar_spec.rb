# frozen_string_literal: true

RSpec.describe SpaceRadar::Radar, 'Test initialisation and mainfunctionality of Radar class' do
  before(:each) do
    @radar = SpaceRadar::Radar.new("#{File.dirname(__FILE__)}/sample_files/board_sample.txt")
    @matcher = Kmp::Matcher.new
  end

  context 'Attributes' do

    it 'has attr_reader the attribute :found_invaders' do
      expect(@radar.found_invaders == []).to be_truthy
      expect { @radar.found_invaders = 10 }.to  raise_error(NoMethodError)
      expect { @radar.found_invaders= 10 }.to  raise_error(NoMethodError)
    end

    it 'has attr_writer attribute :noise_threshold' do
      expect(@radar.noise_threshold == 1).to be_truthy
      expect(@radar.respond_to?(:noise_threshold=)).to be_truthy

      @radar.noise_threshold = 2
      expect(@radar.noise_threshold == 2).to be_truthy
    end

    it 'rejects targets, others than SpaceRadar::SpaceInvader instances' do
      expect { @radar.target = 'sampe' }.to raise_error(ArgumentError)
      target = SpaceRadar::SpaceInvader.new("#{File.dirname(__FILE__)}/sample_files/si1.txt")
      @radar.target = target
      expect(@radar.target == target).to be_truthy
    end
  end

  context 'Search invader' do
    let(:target) { SpaceRadar::SpaceInvader.new("#{File.dirname(__FILE__)}/sample_files/si1.txt") }

    it 'returns false if starting row would cause overflow' do
      @radar.target = target
      expect(@radar.send(:search_invader, @matcher, 48)).to be_falsy
    end

    it 'returns true if target found' do
      @radar.target = target
      expect(@radar.send(:search_invader, @matcher, 0)).to be_truthy
    end
  end

  context 'init_lookout! method' do
    it 'validates target' do
      expect { @radar.init_lookout! }.to raise_error(RuntimeError)
      @radar = SpaceRadar::Radar.new("#{File.dirname(__FILE__)}/sample_files/board_sample.txt", target: 'sample')
      expect { @radar.init_lookout! }.to raise_error(RuntimeError)
    end
  end
end
