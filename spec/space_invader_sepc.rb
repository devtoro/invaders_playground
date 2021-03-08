# frozen_string_literal: true

RSpec.describe SpaceRadar::SpaceInvader, 'Test initialisation and mainfunctionality of SpaceInvader class' do
  context 'Interaction with invader. Find/Hide' do
    let(:invader) { SpaceRadar::SpaceInvader.new("#{File.dirname(__FILE__)}/sample_files/si1.txt") }

    it 'Has found attr false, one initialized' do
      expect(invader.found).to be_falsy
    end

    it 'Has found attr true, once found!' do
      invader.found!
      expect(invader.found).to be_truthy
    end

    it 'Has found attr false, one hidden' do
      invader.hide!
      expect(invader.found).to be_falsy
    end
  end
end
