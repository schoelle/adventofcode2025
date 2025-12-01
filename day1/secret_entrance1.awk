#!/usr/bin/awk -f
BEGIN { p = 50 ; c = 0 }
/^L/ { p = (((p - substr($0, 2)) % 100) + 100) % 100 }
/^R/ { p = (((p + substr($0, 2)) % 100) + 100) % 100 }
{ if (p == 0) c++ }
END { print c }
