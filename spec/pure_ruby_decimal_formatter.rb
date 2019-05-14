# frozen_string_literal: true

require 'active_support/dependencies/autoload'
require 'action_view/helpers/number_helper'

class PureRubyDecimalFormatter
  include ActionView::Helpers::NumberHelper

  def initialize(num, precision)
    @num = num
    @precision = precision
  end

  def format
    number_with_delimiter(@num.round(@precision), delimiter: ',')
  end
end
