require 'spec_helper'

describe 'Benchmark performance' do
  ITERATIONS = 100_000
  MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING = 1.2
  MINIMUM_EXPECTED_SPEEDUP_FACTORS__DELIMITING = 20

  LOW_SPEEDUP_FACTOR_MESSAGE = <<~STR
    If the native C implementation doesn't provide large speedup factor anymore,
    then we should consider using pure Ruby implementation
  STR

  def expect_result_to_have_minimum_speedup_factor(current_result, reference_result, minimum_speedup_factor)
    expect(current_result * minimum_speedup_factor).to be < reference_result, LOW_SPEEDUP_FACTOR_MESSAGE
  end

  describe 'Rounding number' do
    it 'comparing to Ruby string interpolation' do
      results = Benchmark.bm do |x|
        x.report 'Native C implementation' do
          ITERATIONS.times { AeFastDecimalFormatter.new(355.785, 2).format }
        end

        x.report 'Ruby' do
          ITERATIONS.times { PureRubyDecimalFormatter.new(355.785, 2).format }
        end
      end

      native_result, ruby_result = results
      expect_result_to_have_minimum_speedup_factor(native_result.real, ruby_result.real, MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING)
    end
  end

  describe 'Delimit large number' do
    it 'comparing to Ruby string interpolation' do
      results = Benchmark.bm do |x|
        x.report 'Native C implementation' do
          ITERATIONS.times { AeFastDecimalFormatter.new(1234567890, 0).format }
        end

        x.report 'Ruby' do
          ITERATIONS.times { PureRubyDecimalFormatter.new(1234567890, 0).format }
        end
      end

      native_result, ruby_result = results
      expect_result_to_have_minimum_speedup_factor(native_result.real, ruby_result.real, MINIMUM_EXPECTED_SPEEDUP_FACTORS__DELIMITING)
    end
  end
end
