require_relative 'spec_helper'

describe Rover do
  describe 'Rover#initialize' do
    before do
      @mars = Mars.new(5, 5)
      @rover = Rover.new([1, 1], 'E', 'LMMRMM', @mars)
      allow(STDOUT).to receive(:puts)
    end

    it 'can initialize the initial coordinates' do
      expect(@rover.coordinates).to eq([1, 1])
    end

    it 'can initialize the initial orientation' do
      expect(@rover.orientation).to eq('E')
    end

    it 'can initialize the initial path pattern' do
      expect(@rover.path_pattern).to eq('LMMRMM')
    end

    it 'can initialize the mars object' do
      expect(@rover.mars).to eq(@mars)
    end
  end

  describe 'Rover#traverse_path' do
    before do
      @mars = Mars.new(5, 5)
      @rover = Rover.new([1, 1], 'E', 'LMMRMM', @mars)
      allow(STDOUT).to receive(:puts)
    end

    it 'can traverse a valid path' do
      @rover.traverse_path
      expect(@rover.coordinates).to eq([3, 3])
      expect(@rover.orientation).to eq('E')
    end

    it 'can raise an error for going out of the boundary of Mars' do
      rover = Rover.new([1, 1], 'E', 'RMM', @mars)
      expect(rover.traverse_path).to raise_error
    end
  end
end
