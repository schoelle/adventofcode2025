#!/usr/bin/pike

array(int) half(int n) {
  if (n % 2 == 0) {
    return ({ n / 2 });
  } else {
    return ({ });
  }
}

array(int) divisors(int n) {
  array(int) res = ({});
  for (int i=2; i <= (int) sqrt(n); i++) {
    if (n % i == 0) {
      res += ({ i, n / i });
    }
  }
  return Array.uniq(sort(({ 1 }) + res));
}

array(int) cnt_invalid(int a, int b, function(int:array(int)) fn) {
  string a_str = (string) a;
  string b_str = (string) b;
  int a_s = sizeof(a_str);
  int b_s = sizeof(b_str);

  if (a_s != b_s) {
    return cnt_invalid(a, (int) ("9" * a_s), fn) + cnt_invalid((int) ("1" + ("0" * a_s)), b, fn);
  }

  if (a_s < 2) { return ({}); }

  array(int) invalid = ({});
  array(int) parts = fn(a_s);
    
  foreach (parts, int d) {
    string a_pre = a_str[..d-1];
    string b_pre = b_str[..d-1];
    for (int i = (int) a_pre; i <= (int) b_pre; i++) {
      int val = (int) (((string) i) * (a_s / d));
      if ((val >= a) && (val <= b)) {
	invalid += ({ val });
      }
    }
  }
  return invalid;
}

void main(int argc, array(string) argv) {
  string line = String.trim(Stdio.read_file(argv[1]));
  int total1 = 0;
  int total2 = 0;
  foreach(line / ",", string part) {
    sscanf(part,"%d-%d", int a, int b);    
    total1 += Array.sum(Array.uniq(cnt_invalid(a, b, half)));
    total2 += Array.sum(Array.uniq(cnt_invalid(a, b, divisors)));
  }
  write("%d\n", total1);
  write("%d\n", total2);
}
