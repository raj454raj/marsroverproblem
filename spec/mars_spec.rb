require_relative 'spec_helper'

describe Mars do
  describe 'Mars#modify_coordinates' do
    before do
      @mars = Mars.new(5, 5)
    end

    it 'can modify coordinates for N direction' do
      expect(@mars.modify_coordinates([1, 3], 'N')).to eq([1, 4])
      expect(@mars.modify_coordinates([4, 1], 'N')).to eq([4, 2])
    end

    it 'can modify coordinates for S direction' do
      expect(@mars.modify_coordinates([3, 3], 'S')).to eq([3, 2])
      expect(@mars.modify_coordinates([4, 1], 'S')).to eq([4, 0])
    end

    it 'can modify coordinates for W direction' do
      expect(@mars.modify_coordinates([2, 3], 'W')).to eq([1, 3])
      expect(@mars.modify_coordinates([3, 2], 'W')).to eq([2, 2])
    end

    it 'can modify coordinates for E direction' do
      expect(@mars.modify_coordinates([1, 3], 'E')).to eq([2, 3])
      expect(@mars.modify_coordinates([4, 2], 'E')).to eq([5, 2])
    end
  end

  describe 'Mars#not_valid?' do
    before do
      @mars = Mars.new(5, 5)
    end

    it 'can handle a valid coordinate' do
      expect(@mars.not_valid?(2, 3)).to eq(false)
      expect(@mars.not_valid?(0, 5)).to eq(false)
    end

    it 'can handle an under boundary condition' do
      expect(@mars.not_valid?(-1, 2)).to eq(true)
      expect(@mars.not_valid?(4, -3)).to eq(true)
    end

    it 'can handle an over boundary condition' do
      expect(@mars.not_valid?(4, 6)).to eq(true)
      expect(@mars.not_valid?(8, 1)).to eq(true)
    end

    it 'can handle both under and over boundary conditions' do
      expect(@mars.not_valid?(7, -1)).to eq(true)
      expect(@mars.not_valid?(-5, 9)).to eq(true)
    end
  end

  describe 'Mars#obtain_new_position' do
    before do
      @mars = Mars.new(5, 5)
    end

    it 'can obtain a new state with M which is permissible' do
      expect(@mars.obtain_new_position([1, 1], 'E', 'M')).to eq([[2, 1], 'E'])
    end

    it 'can raise an error for an invalid position in M' do
      expect { @mars.obtain_new_position([1, 1], 'E', 'E') }.to raise_error(RuntimeError)
    end

    it 'can obtain a new state with R' do
      expect(@mars.obtain_new_position([1, 1], 'E', 'L')).to eq([[1, 1], 'N'])
    end

    it 'can obtain a new state with R' do
      expect(@mars.obtain_new_position([1, 1], 'E', 'R')).to eq([[1, 1], 'S'])
    end
  end
end
