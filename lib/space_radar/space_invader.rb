# frozen_string_literal: true

module SpaceRadar
  # Defines a standard space invader
  class SpaceInvader < Board
    attr_reader :found

    # Inits found attr as false
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
