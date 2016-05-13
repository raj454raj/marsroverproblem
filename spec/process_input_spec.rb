require_relative 'spec_helper'

describe ProcessInput do
  before do
    allow(STDOUT).to receive(:puts)
    @process_input = ProcessInput.new("5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM\n")
  end

  describe 'ProcessInput#validate_test_case_size' do
    it 'can determine size of the testcase' do
      # Note: ProcessInput#initialize has already called validate_test_case_size
      expect(@process_input.test_cases).to eq(2)
      @process_input.validate_test_case_size
      expect(@process_input.test_cases).to eq(1)
    end

    it 'can raise an error for invalid testcase size' do
      expect { ProcessInput.new("5 5\n1 2 N\nLMLMLMLMM\n3 3 E\n") }.to raise_error(RuntimeError)
      expect { ProcessInput.new("5 5\n1 2 N\nLMLMLMLMM\n3 3 E") }.to raise_error(RuntimeError)
      expect { ProcessInput.new("5 5\n1 2 N") }.to raise_error(RuntimeError)
    end
  end

  describe 'ProcessInput#obtain_dimensions' do
    it 'can get dimensions from a valid input' do
      expect(@process_input.obtain_dimensions).to eq([5, 5])
    end

    it 'can raise an error for non-integers in the input' do
      process_input = ProcessInput.new("a 5\n1 2 N\nLMLMMLM")
      expect { process_input.obtain_dimensions }.to raise_error(ArgumentError)
    end

    it 'can raise an error for negative coordinates in the input' do
      process_input = ProcessInput.new("-1 5\n1 2 N\nLMLMLMLM")
      expect { process_input.obtain_dimensions }.to raise_error(RuntimeError)
    end
  end

  describe 'ProcessInput#is_i?' do
    it 'can identify a string represents an integer' do
      expect(@process_input.is_i?('4')).to eq(true)
      expect(@process_input.is_i?('45')).to eq(true)
    end

    it 'can raise an error if a string does not represent an integer' do
      expect { @process_input.is_i?('a') }.to raise_error(ArgumentError)
      expect { @process_input.is_i?('36a') }.to raise_error(ArgumentError)
    end
  end

  describe 'ProcessInput#obtain_current_state' do
    it 'can get the current state for valid input' do
      expect(@process_input.obtain_current_state(0)).to eq([1, 2, 'N'])
      expect(@process_input.obtain_current_state(1)).to eq([3, 3, 'E'])
    end

    it 'can raise an error for invalid initial x coordinate' do
      process_input = ProcessInput.new("5 5\na 2 N\nLMLMMLM\n")
      expect { process_input.obtain_current_state(0) }.to raise_error(ArgumentError)
    end

    it 'can raise an error for invalid initial y coordinate' do
      process_input = ProcessInput.new("5 5\n1 b N\nLMLMMLM\n")
      expect { process_input.obtain_current_state(0) }.to raise_error(ArgumentError)
    end

    it 'can raise an error for invalid initial orientation' do
      process_input = ProcessInput.new("5 5\n1 2 R\nLMLMMLM\n")
      expect { process_input.obtain_current_state(0) }.to raise_error(RuntimeError)
    end
  end

  describe 'ProcessInput#obtain_path_pattern' do
    it 'can return a path pattern for a valid input' do
      expect(@process_input.obtain_path_pattern(0)).to eq('LMLMLMLMM')
      expect(@process_input.obtain_path_pattern(1)).to eq('MMRMMRMRRM')
    end

    it 'can raise an error for an invalid path pattern' do
      process_input = ProcessInput.new("5 5\n1 2 R\nLMLMMLWW\n")
      expect { process_input.obtain_path_pattern(0) }.to raise_error(RuntimeError)
    end
  end
end
