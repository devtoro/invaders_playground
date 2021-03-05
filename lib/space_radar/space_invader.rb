# frozen_string_literal: true

module SpaceRadar
  # Defines a standard space invader
  class SpaceInvader < Board
    attr_reader :found

    # Expects input to be a txt file or a path to a txt file
    def initialize(input)
      super
      @found = false
    end

    def found!
      @found = true
    end

    def hide!
      @found = false
    end
  end
end
