# frozen_string_literal: true

require 'active_support/dependencies/autoload'
require 'action_view/helpers/number_helper'

class PureRubyDecimalFormatter
  include ActionView::Helpers::NumberHelper

  def format(num, precision)
    number_with_delimiter(num.round(precision), delimiter: ',')
  end
end
