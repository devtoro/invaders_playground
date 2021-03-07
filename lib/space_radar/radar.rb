# frozen_string_literal: true

module SpaceRadar
  # Defines a Radar object that will search for space invader. Inherits from board
  # noise_threshold defines the tollerance for inncorrect matches for evey scan itteration
  # found invaders is a counter
  class Radar < Board
    attr_reader :found_invaders, :target
    attr_accessor :noise_threshold

    # Default noise_threshold is set to 1
    def initialize(input, noise_threshold: 1, target: nil)
      super(input)
      @noise_threshold = noise_threshold
      @found_invaders = []
      @target = target
    end

    def target=(space_invader)
      raise ArgumentError, 'Space invader should be a ::SpaceInvader' unless space_invader.is_a? SpaceInvader

      @target = space_invader
      init_lookout!
      @found_invaders.push(@target) if @target.found
    end

    def init_lookout!
      matcher = Kmp::Matcher.new noise_threshold: @noise_threshold
      raise 'Target not set' if @target.nil?
      raise 'Target should be an instance of SpaceRadar::SpaceInvader' unless @target.is_a?(SpaceRadar::SpaceInvader)

      search_invader matcher, 0
      @found_invaders.push @target if @target.found
    end

    private

    def search_invader(matcher, starting_row, match_list = [])
      return false if (@body.length - starting_row) < @target.body.length

      @target.body.each_with_index do |pattern, i|
        matcher.pattern = pattern
        matcher.context = @body[starting_row + i]
        matcher.starting_index = next_starting_index(match_list)
        mr = matcher.check!
        return search_invader(matcher, (starting_row + 1), match_list) unless mr.match

        match_list << mr
        @target.found! if match_list.count == @target.body.count
        return @target.found if @target.found
      end
    end

    def next_starting_index(match_list = [])
      raise ArgumentError, 'Argument should be an array of Kmp::Match' unless match_list.is_a?(Array)

      last_match = match_list.last
      return 0 if last_match.nil?

      raise ArgumentError, 'Argument should only have instances of Kmp::Match' unless last_match.is_a?(Kmp::Match)

      last_match.matched_index
    end
  end
end
