require 'spec_helper'
require 'bigdecimal'

describe 'AeFastDecimalFormatter' do
  def ae_fast_decimal_formatter(number, precision)
    AeFastDecimalFormatter.format(number, precision)
  end

  describe 'floating point numbers' do
    describe 'precision greater than 0' do
      it 'small number with rounding up' do
        expect(ae_fast_decimal_formatter(355.786, 2)).to eq('355.79')
      end

      it 'small number with rounding up at tricky value' do
        expect(ae_fast_decimal_formatter(355.785, 2)).to eq('355.79')
      end

      it 'small number with rounding up at tricky value - take 2' do
        expect(ae_fast_decimal_formatter(148.855, 2)).to eq('148.86')
      end

      it 'small number with rounding down at tricky value' do
        expect(ae_fast_decimal_formatter(355.784, 2)).to eq('355.78')
      end

      it 'medium number without rounding' do
        expect(ae_fast_decimal_formatter(12347.56, 2)).to eq('12,347.56')
      end

      it 'large number without rounding' do
        expect(ae_fast_decimal_formatter(1234567890.12, 2)).to eq('1,234,567,890.12')
      end

      it 'precision is 1' do
        expect(ae_fast_decimal_formatter(355.784, 1)).to eq('355.8')
      end
    end

    describe 'Precision is 0' do
      it 'small number' do
        expect(ae_fast_decimal_formatter(2.556, 0)).to eq('3')
      end

      it 'tricky case 1' do
        expect(ae_fast_decimal_formatter(14885.5, 0)).to eq('14,886')
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

      it 'tricky number 1' do
        expect(ae_fast_decimal_formatter(-1.444444, 2)).to eq('-1.44')
      end

      it 'large number' do
        expect(ae_fast_decimal_formatter(-1234567890.12, 2)).to eq('-1,234,567,890.12')
      end
    end

    describe 'zero' do
      it 'pure zero' do
        expect(ae_fast_decimal_formatter(0, 0)).to eq('0')
      end

      it 'negative zero' do
        expect(ae_fast_decimal_formatter(-0, 0)).to eq('0')
      end

      it 'zero with decimal' do
        expect(ae_fast_decimal_formatter(0.000, 0)).to eq('0')
      end

      it 'zero with small positive decimal' do
        expect(ae_fast_decimal_formatter(0.01, 0)).to eq('0')
      end
    end
  end

  describe 'big decimal numbers' do
    describe 'Precision greater than 0' do
      it 'small number with rounding up' do
        expect(ae_fast_decimal_formatter(BigDecimal('355.786'), 2)).to eq('355.79')
      end

      it 'small number with rounding up at tricky value' do
        expect(ae_fast_decimal_formatter(BigDecimal('355.785'), 2)).to eq('355.79')
      end

      it 'small number with rounding up at tricky value - take 2' do
        expect(ae_fast_decimal_formatter(BigDecimal('148.855'), 2)).to eq('148.86')
      end

      it 'small number with rounding down at tricky value' do
        expect(ae_fast_decimal_formatter(BigDecimal('355.784'), 2)).to eq('355.78')
      end

      it 'medium number without rounding' do
        expect(ae_fast_decimal_formatter(BigDecimal('12347.56'), 2)).to eq('12,347.56')
      end

      it 'large number without rounding' do
        expect(ae_fast_decimal_formatter(BigDecimal('1234567890.12'), 2)).to eq('1,234,567,890.12')
      end

      it 'precision is 1' do
        expect(ae_fast_decimal_formatter(BigDecimal('355.784'), 1)).to eq('355.8')
      end
    end

    describe 'precision is 0' do
      it 'small number' do
        expect(ae_fast_decimal_formatter(BigDecimal('2.556'), 0)).to eq('3')
      end

      it 'tricky case 1' do
        expect(ae_fast_decimal_formatter(BigDecimal('14885.5'), 0)).to eq('14,886')
      end

      it 'large number' do
        expect(ae_fast_decimal_formatter(BigDecimal('1234567890.12'), 0)).to eq('1,234,567,890')
      end
    end

    describe 'Precision is greater than 5' do
      it 'only round to 5 precision points' do
        expect(ae_fast_decimal_formatter(BigDecimal('2.3456789'), 7)).to eq('2.34568')
      end
    end

    describe 'Negative number' do
      it 'small number' do
        expect(ae_fast_decimal_formatter(BigDecimal('-2.556'), 2)).to eq('-2.56')
      end

      it 'tricky number 1' do
        expect(ae_fast_decimal_formatter(BigDecimal('-1.444444'), 2)).to eq('-1.44')
      end

      it 'large number' do
        expect(ae_fast_decimal_formatter(BigDecimal('-1234567890.12'), 2)).to eq('-1,234,567,890.12')
      end
    end

    describe 'zero' do
      it 'pure zero' do
        expect(ae_fast_decimal_formatter(BigDecimal('0'), 0)).to eq('0')
      end

      it 'negative zero' do
        expect(ae_fast_decimal_formatter(BigDecimal('-0'), 0)).to eq('0')
      end

      it 'zero with decimal' do
        expect(ae_fast_decimal_formatter(BigDecimal('0.000'), 0)).to eq('0')
      end

      it 'zero with small positive decimal' do
        expect(ae_fast_decimal_formatter(BigDecimal('0.01'), 0)).to eq('0')
      end
    end
  end

end


