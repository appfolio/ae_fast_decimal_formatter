require "mkmf"

abort "missing snprintf()" unless have_func "snprintf"
abort "missing strncmp()"  unless have_func "strncmp"

create_makefile "ae_fast_decimal_formatter/ae_fast_decimal_formatter"
