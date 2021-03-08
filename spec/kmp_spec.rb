# frozen_string_literal: true

RSpec.describe Kmp::Matcher, 'Test initialisation and main methods of Kmp::Matcher' do
  before(:each) { @kmp = Kmp::Matcher.new(context: 'sample', pattern: 'les', starting_index: 0, noise_threshold: 1) }

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

  context 'Updating attributes' do
    it 'raises argument error if invalid argument is passed' do
      kmp = Kmp::Matcher.new
      expect { kmp.update_attributes(darth: 'vader') }.to raise_error(ArgumentError)
    end

    it 'updates attributes for valid keys passed' do
      kmp = Kmp::Matcher.new
      kmp.update_attributes context: 'anakin skywalker'
      expect(kmp.context == 'anakin skywalker').to be_truthy
    end
  end

  context 'Algorithm response' do
    it 'is a Kmp::Match instance' do
      result = @kmp.check!
      expect(result.is_a?(Kmp::Match)).to be_truthy
      expect(result.respond_to?(:match)).to be_truthy
      expect(result.respond_to?(:matched_index)).to be_truthy
    end

    it 'responds to :match method with value the context matching pattern, in case of a match' do
      result = @kmp.check!
      expect(result.match == 'les').to be_truthy
      expect(result.matched_index == 4).to be_truthy
    end
  end

  context 'Private methods' do
    it 'sends build_edge_pattern and should cycle through the characters' do
      string = 'ruby!'
      expect(@kmp.send(:build_edge_pattern, string, 3, 3) == 'y!r').to be_truthy
    end

    it 'send build_check_pattern and should cycle through the characters if needed' do
      string = 'space invaders'
      expect(@kmp.send(:build_check_pattern, string, 0, 3) == 'spa').to be_truthy
      expect(@kmp.send(:build_check_pattern, string, 12, 3) == 'rss').to be_truthy
    end

    it 'Validate check pattern builders and raises error if :pattern_length > string.length' do
      expect { @kmp.send(:build_check_pattern, 'space', 0, 12) }.to raise_error(RuntimeError)
      expect { @kmp.send(:build_edge_pattern, 'space', 0, 12) }.to raise_error(RuntimeError)
    end

    it 'sends check_match and returns false in case of miss and context substring in case of match' do
      expect(@kmp.send(:check_match, 'space', 'invade')).to be_falsy
    end

    it 'sends check_match and returns matched string if match. Matched string should be the first arguement' do
      expect(@kmp.send(:check_match, 'spa', 'sps') == 'spa').to be_truthy
    end
  end
end
