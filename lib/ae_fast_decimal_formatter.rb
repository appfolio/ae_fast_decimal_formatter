require 'bigdecimal'

class AeFastDecimalFormatter
  def self.format(number, precision)
    precision = 0 if precision < 0
    precision = 5 if precision > 5

    # We can call to_f on the input to convert variety of types to floats. This is
    # faster than inspecting the type of the input and performing different logic.
    # This is safe as we have a test that verifies we produce the same result for
    # float as we do for BigDecimals (i.e. format_long((num * 10 ** precision).round, precision)).
    #
    # In order to round correct, it looks like we need the two sets of rounds. For example,
    # (148.855 * 100).round.to_i -> 14885 seems incorrect, so we try,
    # (148.855.round(2) * 100).to_i -> 14886 but then,
    # (1234567890.12.round(2) * 100).to_i -> 123456789011 which is definitely not correct.
    #
    # Thus the two rounds.
    format_long((number.to_f.round(precision) * 10 ** precision).round, precision)
  end
end

require "ae_fast_decimal_formatter/ae_fast_decimal_formatter"
