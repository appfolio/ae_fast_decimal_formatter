require 'spec_helper'
require 'benchmark/ips'

describe 'Benchmark performance' do
  MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING = 1.2
  MINIMUM_EXPECTED_SPEEDUP_FACTORS__DELIMITING = 20
  BENCHMARK_IPS_QUIET = true

  LOW_SPEEDUP_FACTOR_MESSAGE = <<~STR
    If the native C implementation doesn't provide large speedup factor anymore,
    then we should consider using pure Ruby implementation
  STR

  def expect_result_to_have_minimum_speedup_factor(current_result, reference_result, minimum_speedup_factor)
    expect(current_result * minimum_speedup_factor).to be < reference_result, LOW_SPEEDUP_FACTOR_MESSAGE
  end

  describe 'formatting Fixnum' do
    it 'should be faster in C' do
      formatter = PureRubyDecimalFormatter.new
      results = Benchmark.ips(quiet: BENCHMARK_IPS_QUIET) do |x|
        x.report 'Ruby fixnum' do
          formatter.format(1234567890, 0)
        end

        x.report 'C fixnum' do
          AeFastDecimalFormatter.format(1234567890, 0)
        end

        x.compare!
      end

      ruby_result, c_result = results.data
      expect_result_to_have_minimum_speedup_factor(
        ruby_result[:cycles],
        c_result[:cycles],
        MINIMUM_EXPECTED_SPEEDUP_FACTORS__DELIMITING
      )
    end
  end

  describe 'formatting Float' do
    it 'should be faster in C' do
      formatter = PureRubyDecimalFormatter.new
      results = Benchmark.ips(quiet: BENCHMARK_IPS_QUIET) do |x|
        x.report 'Ruby float' do
          formatter.format(355.785, 2)
        end

        x.report 'C float' do
          AeFastDecimalFormatter.format(355.785, 2)
        end

        x.compare!
      end

      ruby_result, c_result = results.data
      expect_result_to_have_minimum_speedup_factor(
        ruby_result[:cycles],
        c_result[:cycles],
        MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING
      )
    end
  end

  describe 'formatting BigDecimal' do
    it 'should be faster in C' do
      formatter = PureRubyDecimalFormatter.new
      decimal = BigDecimal('355.785')
      results = Benchmark.ips(quiet: BENCHMARK_IPS_QUIET) do |x|
        x.report 'Ruby decimal.to_f' do
          formatter.format(decimal.to_f, 2)
        end

        x.report 'C decimal' do
          AeFastDecimalFormatter.format(decimal, 2)
        end

        x.compare!
      end

      ruby_result, c_result = results.data
      expect_result_to_have_minimum_speedup_factor(
        ruby_result[:cycles],
        c_result[:cycles],
        MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING
      )
    end
  end

  describe 'formatting string' do
    it 'should be faster in C' do
      formatter = PureRubyDecimalFormatter.new
      results = Benchmark.ips(quiet: BENCHMARK_IPS_QUIET) do |x|
        x.report 'Ruby string.to_f' do
          formatter.format('355.785'.to_f, 2)
        end

        x.report 'C string' do
          AeFastDecimalFormatter.format('355.785', 2)
        end

        x.compare!
      end

      ruby_result, c_result = results.data
      expect_result_to_have_minimum_speedup_factor(
        ruby_result[:cycles],
        c_result[:cycles],
        MINIMUM_EXPECTED_SPEEDUP_FACTORS__ROUNDING
      )
    end
  end
end
