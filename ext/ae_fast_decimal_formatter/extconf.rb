require "mkmf"

append_cflags("-std=c99")

create_makefile "ae_fast_decimal_formatter/ae_fast_decimal_formatter"
