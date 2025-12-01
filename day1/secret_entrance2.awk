#!/usr/bin/awk -f
BEGIN { p = 50 ; c = 0 }
/^L/ {
    v = substr($0, 2)
    c += int(((100 - p) % 100 + v) / 100)
    p = (((p - v) % 100) + 100) % 100
}
/^R/ {
    v = substr($0, 2)
    c += int((v + p) / 100)
    p = (((v + p) % 100) + 100) % 100
}
END { print c }
