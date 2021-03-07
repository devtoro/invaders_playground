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

      search_invader matcher, 0
      @found_invaders.push @target if @target.found
    end

    def search_invader(matcher, starting_row, match_list = [])
      return false if (@body.length - starting_row) < @target.body.length

      @target.body.each_with_index do |pattern, i|
        matcher.pattern = pattern
        matcher.context = @body[starting_row + i]
        matcher.starting_index = match_list.last.nil? ? 0 : match_list.last.matched_index

        mr = matcher.check!
        if mr.match
          match_list << mr
          @target.found! if match_list.count == @target.body.count
          return @target.found if @target.found
        else
          next_row = starting_row + 1
          return search_invader(matcher, next_row, match_list)
        end
      end
    end
  end
end
