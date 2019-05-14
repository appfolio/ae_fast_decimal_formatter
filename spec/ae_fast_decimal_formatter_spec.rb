require 'spec_helper'

describe 'AeFastDecimalFormatter' do
  def ae_fast_decimal_formatter(number, precision)
    AeFastDecimalFormatter.new(number, precision).format
  end

  describe 'Precision greater than 0' do
    it 'small number with rounding up' do
      expect(ae_fast_decimal_formatter(2.556, 2)).to eq('2.56')
    end

    it 'small number with rounding up at tricky value' do
      expect(ae_fast_decimal_formatter(2.555, 2)).to eq('2.56')
    end

    it 'small number with rounding down at tricky value' do
      expect(ae_fast_decimal_formatter(2.554, 2)).to eq('2.55')
    end

    it 'medium number without rounding' do
      expect(ae_fast_decimal_formatter(1234.56, 2)).to eq('1,234.56')
    end

    it 'large number without rounding' do
      expect(ae_fast_decimal_formatter(1234567890.12, 2)).to eq('1,234,567,890.12')
    end
  end

  describe 'Precision is 0' do
    it 'small number' do
      expect(ae_fast_decimal_formatter(2.556, 0)).to eq('3')
    end

    it 'large number' do
      expect(ae_fast_decimal_formatter(1234567890.12, 0)).to eq('1,234,567,890')
    end
  end

  describe 'Precision is greater than 5' do
    it 'only round to 5 precision points' do
      expect(ae_fast_decimal_formatter(2.3456789, 7)).to eq('2.34568')
    end
  end

  describe 'Negative number' do
    it 'small number' do
      expect(ae_fast_decimal_formatter(-2.556, 2)).to eq('-2.56')
    end

    it 'large number' do
      expect(ae_fast_decimal_formatter(-1234567890.12, 2)).to eq('-1,234,567,890.12')
    end
  end
end
