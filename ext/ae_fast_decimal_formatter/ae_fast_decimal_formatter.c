#include <ruby.h>
#include <float.h>

inline static char * long_to_formatted_string(long value, char *str, unsigned int strlen, unsigned int precision) {
  char *p;
  unsigned long v;

  v = (value < 0) ? -value : value;
  p = str + strlen - 1;

  // Copy all the precision digits
  for (unsigned int i = 0; i < precision; i++) {
    *p-- = '0' + (v % 10);
    v /= 10;
  }

  // Add the dot
  if (precision > 0) {
    *p-- = '.';
  }

  // Copy all the digits, adding a comma every 3rd digit
  int digits = 0;
  do {
    *p-- = '0' + (v % 10);
    v /= 10;

    if ((++digits % 3) == 0 && v) {
      *p-- = ',';
    }
  } while(v);

  // Finally, add the - if we started with a negative number
  if (value < 0) *p-- = '-';

  // And adjust the p to undo the last p--
  p++;

  return p;
}

// The function takes a value num (assumed to be fixnum) and value precision (assumed to be fixnum
// between 0 and 5) and returns num as a formatted string.
//
// For example, given 100, 2 the function will output "1.00".
// For example, given 123456, 2 the function will output "1,234.56".
// For example, given -1234, 0 the function will output "-1,234".
static VALUE ae_fast_decimal_formatter_format_long(VALUE self, VALUE num, VALUE precision) {
  // The maximum length is 28 characters: 20 digits (assuming 64bits), 6 commas,
  // negative sign, and a period. So we will always fit in 32 chars.
  char buf[32];
  char *numstr = long_to_formatted_string(NUM2LONG(num), buf, 32, NUM2UINT(precision));

  // The rb_str_new takes a pointer to a string and a length. It does not rely on
  // null terminated strings.
  return rb_str_new(numstr, 32 - (int)(numstr - buf));
}

void Init_ae_fast_decimal_formatter(void) {
  VALUE cFastDecimalFormatter;

  cFastDecimalFormatter = rb_const_get(rb_cObject, rb_intern("AeFastDecimalFormatter"));

  rb_define_singleton_method(cFastDecimalFormatter, "format_long", ae_fast_decimal_formatter_format_long, 2);
}
