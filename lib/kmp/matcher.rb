# frozen_string_literal: true

# Implement Knuth-Morris-Pratt (KMP) algorith
# Include edge cases in matching
module Kmp
  # KMP Matcher. Holds logic of the KMP algorithm
  # and extendes it to check beyond the edges in a cycling manner
  #
  # e.g. check if 'sm' matches with 'manolis':
  # starting from :starting_index we will itterate until we reach the last character of :context
  # 1. we breakdown the context into substrings of length pattern.length
  # 3. We check each character in the generated strings for equality and return
  #    a match if (all - noise_threshold) characted have matched successfully
  # Noise threshold can be altered on each instance of the object
  class Matcher
    attr_reader :context, :pattern, :starting_index
    attr_accessor :noise_threshold

    def initialize(context: '', pattern: '', starting_index: 0, noise_threshold: 0)
      @context = context
      @pattern = pattern
      @starting_index = starting_index
      @noise_threshold = noise_threshold
      validate!
    end

    # Returns a Hash instance with the matched text and the matched index
    def check!
      index = @starting_index
      match = false

      while (index < @context.length) && !match
        check_pattern = build_check_pattern(@context, index, @pattern.length)

        match = check_match(check_pattern, @pattern)
        index += 1 unless match
      end

      { match: match, matched_index: index }
    end

    protected

    # Arguments validation for initialization and not only
    def validate!
      raise ArgumentError, 'Context should be a String' unless @context.is_a? String
      raise ArgumentError, 'Pattern should be a String' unless @pattern.is_a? String
      raise ArgumentError, 'Starting Index should be an Integer' unless @starting_index.is_a?(Integer)
      raise ArgumentError, 'Starting Index should be >= 0' unless @starting_index >= 0
      raise ArgumentError, 'Noise Threshold should be an Integer' unless @noise_threshold.is_a?(Integer)
      raise ArgumentError, 'Noise Threshold should be >= 0' unless @noise_threshold >= 0
    end

    private

    # 1
    # Get substring of checked context, in order to check for a match
    # If we exceed the length of the context string, we concat form the beginning
    def build_check_pattern(string, index, pattern_length)
      validate_pattern_builder(string.length, pattern_length)

      index = tokenized_index(string, index)
      if index + pattern_length > string.length
        build_edge_pattern(string, index, pattern_length)
      else
        string[index..(index + pattern_length) - 1]
      end
    end

    # 2
    # For edge cases, when the generated substring shall exceed the limits of the context string,
    # we concat the remaing characted from the beginning of the context string
    def build_edge_pattern(string, index, pattern_length)
      validate_pattern_builder(string.length, pattern_length)

      index = tokenized_index(string, index)
      part1 = string[index..string.length]
      part2 = string[0..(index + pattern_length).modulo(string.length) - 1]
      "#{part1}#{part2}"
    end

    # 3
    # For edge cases, we need the modulo of the index, in order to always have a valid
    # substring from matching
    def tokenized_index(string, index)
      index.modulo(string.length)
    end

    # 4
    # Main checking method
    # Interrates each character of both strings and returns a match based on @noise_threshold
    # In case of match, returns substring from @context
    # Else, reterns FALSE
    def check_match(sc_p, s_p)
      noise = @noise_threshold
      found = false
      match = ''

      sc_p.length.times do |i|
        noise -= 1 if sc_p[i] != s_p[i]
        # Cannot use match << s_p[i] because of frozen string literal comment on top
        match = "#{match}#{sc_p[i]}" if noise >= 0
        found = match.length == s_p.length
      end

      found ? match : found
    end

    def validate_pattern_builder(s_length, p_length)
      raise 'Pattern length cannot be bigger than the length of the string' unless p_length <= s_length
    end
  end
end
