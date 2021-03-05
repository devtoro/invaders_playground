# frozen_string_literal: true

module SpaceRadar
  # Defines a standard space invader
  class SpaceInvader
    attr_reader :size, :body, :found

    ACCEPTABLE_TYPE = 'text/plain'

    # Expects input to be a txt file or a path to a txt file
    def initialize(input)
      raise ArgumentError, 'Input should be a file or a path to a file' unless input.is_a?(File) || input.is_a?(String)

      @body = parse_input(input)
      rows_lengths = @body.map(&:length).uniq

      raise 'Invader is not symetrical' unless rows_lengths.count.equal? 1

      @size = "#{rows_lengths.first}x#{@body.count}"
      @found = false
    end

    def show
      @body.each { |row| puts row }
      self
    end

    def found!
      @found = true
    end

    def hide!
      @found = false
    end

    private

    def parse_input(input)
      file = File.open input
      check_file_type(file)
      invader = File.readlines(file)

      invader.map(&:chomp)
    rescue Errno::ENOENT
      raise 'File not found'
    end

    def check_file_type(file)
      path = file.path
      mime_type = IO.popen(['file', '--brief', '--mime-type', path], &:read).chomp

      raise ArgumentError, "File should be of type #{ACCEPTABLE_TYPE}" unless mime_type == ACCEPTABLE_TYPE
    end
  end
end
