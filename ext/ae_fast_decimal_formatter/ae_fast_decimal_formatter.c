#include <ruby.h>
#include <float.h>

VALUE c_format_decimal(double num, int precision)
{
  char numstr[100];
  char str[DBL_MAX_10_EXP + 2];
  int numi, numlen, stri, strl;
  int maxp = 5, i;
  char formatstr[10];
  int digits_to_comma;
  double rounding_factor, rounded_num;

  if (precision > maxp) { precision = maxp; }
  if (precision < 0) { precision = 0; }

  snprintf(formatstr, 10, "%%.%df", precision);
  formatstr[9] = 0;

  if (precision > 0) {
    rounding_factor = (double) 10.0;
    for (i = 1; i < precision; i++) { rounding_factor *= (double) 10.0; }

    double multiplied_num = num * (double) 10.0;
    for (i = 1; i < precision; i++) { multiplied_num *= (double) 10.0; }

    rounded_num = round(multiplied_num) / rounding_factor;
  } else {
    rounded_num = round(num);
  }

  if (precision > 0) { precision++; } // adjust for .

  numlen = snprintf(numstr, 100, formatstr, rounded_num);
  digits_to_comma = numlen - precision;
  if (numstr[0] == '-') { digits_to_comma--; }

  strl = numlen + (digits_to_comma / 3);
  if ((digits_to_comma % 3) == 0) {
    strl--;
  }

  if (strncmp(numstr, "-0.00000", strl) == 0) {
    return rb_str_new("0.00000", 1 + precision);
  }

  stri = strl;
  str[stri] = 0;
  for (i = 1; i <= (precision + 1); i++) {
    str[stri - i] = numstr[numlen - i];
  }

  stri -= (precision + 2);
  numlen -= (precision + 1);
  numi = 1;

  while ((numlen - numi) >= 1) {
    if ((numi % 3) == 0) {
      str[stri] = ',';
      stri--;
    }
    str[stri] = numstr[numlen - numi];
    stri--;
    numi++;
  }

  if (numstr[0] == '-') {
    str[0] = '-';
  } else {
    if ((numi % 3) == 0) {
      str[1] = ',';
    }
    str[0] = numstr[0];
  }
  return rb_str_new2(str);
}

struct ae_fast_decimal_formatter {
  double num;
  int precision;
};

static void ae_fast_decimal_formatter_free(void *p) {}

static VALUE ae_fast_decimal_formatter_alloc(VALUE klass) {
  VALUE obj;
  struct ae_fast_decimal_formatter *ptr;

  obj = Data_Make_Struct(klass, struct ae_fast_decimal_formatter, NULL, ae_fast_decimal_formatter_free, ptr);

  ptr->num = 0.0;
  ptr->precision = 0;

  return obj;
}

static VALUE ae_fast_decimal_formatter_init(VALUE self, VALUE number, VALUE precision) {
  struct ae_fast_decimal_formatter *ptr;
  Data_Get_Struct(self, struct ae_fast_decimal_formatter, ptr);
  ptr->num = NUM2DBL(number);
  ptr->precision = NUM2UINT(precision);
  return self;
}

static VALUE ae_fast_decimal_formatter_format(VALUE self) {
  struct ae_fast_decimal_formatter *ptr;
  Data_Get_Struct(self, struct ae_fast_decimal_formatter, ptr);
  return c_format_decimal(ptr->num, ptr->precision);
}

void Init_ae_fast_decimal_formatter(void) {
  VALUE cFastDecimalFormatter;

  cFastDecimalFormatter = rb_const_get(rb_cObject, rb_intern("AeFastDecimalFormatter"));

  rb_define_alloc_func(cFastDecimalFormatter, ae_fast_decimal_formatter_alloc);
  rb_define_method(cFastDecimalFormatter, "initialize", ae_fast_decimal_formatter_init, 2);
  rb_define_method(cFastDecimalFormatter, "format", ae_fast_decimal_formatter_format, 0);
}
