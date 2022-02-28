require 'bigdecimal'

class AeFastDecimalFormatter
  def self.format(number, precision)
    precision = 0 if precision < 0
    precision = 5 if precision > 5

    if number.is_a?(BigDecimal)
      # With BigDecimal, we do not need to call round twice.
      format_long((number * 10 ** precision).round, precision)
    else
      # It looks like we need the two sets of rounds in order to attempt
      # to round floating numbers. For example,
      # (148.855 * 100).round -> 14885 seems incorrect, so we try,
      # 148.855.round(2) * 100 -> 14886 but then,
      # (1234567890.12.round(2) * 100).to_i -> 123456789011 which is
      # definitely not correct. Thus the two rounds.
      format_long((number.round(precision) * 10 ** precision).round, precision)
    end
  end
end

require "ae_fast_decimal_formatter/ae_fast_decimal_formatter"
