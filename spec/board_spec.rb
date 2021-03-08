# frozen_string_literal: true

RSpec.describe SpaceRadar::Board, 'Test initialisation and mainfunctionality of Board class' do
  context 'Init input validation' do
    it 'Raises Argument error if init argument empty or invalid(not String or not File)' do
      expect { SpaceRadar::Board.new }.to raise_error(ArgumentError)
      expect { SpaceRadar::Board.new(1) }.to raise_error(ArgumentError)
    end

    it 'Raises RuntimeError if string is not a path to a file' do
      expect { SpaceRadar::Board.new('sample') }.to raise_error(RuntimeError)
    end

    it 'Raises Runtime errror if invader not symetrical' do
      file = File.open("#{File.dirname(__FILE__)}/sample_files/si1_falsy.txt")
      expect { SpaceRadar::Board.new file }.to raise_error(RuntimeError)
    end

    it 'Returns an instance of Board upon proper input' do
      file_path = "#{File.dirname(__FILE__)}/sample_files/si1.txt"
      file = File.open file_path

      expect(SpaceRadar::Board.new(file).is_a?(SpaceRadar::Board)).to be_truthy
      expect(SpaceRadar::Board.new(file_path).is_a?(SpaceRadar::Board)).to be_truthy
    end

    it 'Has size attribute that returns cols x rows in a string' do
      file_path = "#{File.dirname(__FILE__)}/sample_files/board_sample.txt"
      board = SpaceRadar::Board.new file_path

      expect(board.respond_to?(:size)).to be_truthy
      expect(board.size == "#{board.body.first.length}x#{board.body.count}").to be_truthy
    end
  end
end
