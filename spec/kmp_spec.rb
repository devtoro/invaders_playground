# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kmp::Matcher, 'Test initialisation and main methods of Kmp::Matcher' do
  context 'Initializing' do
    let(:valid_init_attr) { { context: 'sample', pattern: 'les', starting_index: 0, noise_threshold: 1 } }

    it 'validates input for initialization' do
      { context: 2, pattern: true, starting_index: -1, noise_threshold: 'yes' }.each do |k, v|
        attrs = valid_init_attr
        attrs[k] = v
        expect { Kmp::Matcher.new(**attrs) }.to raise_error(ArgumentError)
      end
    end
  end

  context 'Private methods' do
    let(:kmp) { Kmp::Matcher.new(context: 'sample', pattern: 'les', starting_index: 0, noise_threshold: 1) }

    it 'sends build_edge_pattern and should cycle through the characters' do
      string = 'ruby!'
      expect(kmp.send(:build_edge_pattern, string, 3, 3) == 'y!r').to be_truthy
    end

    it 'send build_check_pattern and should cycle through the characters if needed' do
      string = 'space invaders'
      expect(kmp.send(:build_check_pattern, string, 0, 3) == 'spa').to be_truthy
      expect(kmp.send(:build_check_pattern, string, 12, 3) == 'rss').to be_truthy
    end

    it 'sends build_check_pattern and raises error if :pattern_length > string.length'
    it 'sends build_edge_pattern and raises error if :pattern_length > string.length'
    it 'sends check_match and returns false in case of miss'
    it 'sends check_match and returns matched string if match. Matched string should be the first arguement'
  end
end
