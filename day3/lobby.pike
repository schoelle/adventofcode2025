#!/usr/bin/pike


mapping(string:string) cache = ([]);

string add_cache(string id, string value) {
  cache[id] = value;
  return value;
}

string joltage(string line, int cnt) {
  string id = sprintf("%d-%s", cnt, line);
  if (has_index(cache, id)) {
    return cache[id];
  }
  if (cnt < 1) {
    return "";
  }
  if (sizeof(line) == cnt) {
    return add_cache(id, line);
  }
  string val1 = line[0..0] + joltage(line[1..], cnt-1);
  string val2 = joltage(line[1..], cnt);
  if ((int) val1 > (int) val2) {
    return add_cache(id, val1);
  } else {
    return add_cache(id, val2);
  }
}

void main(int argc, array(string) argv) {
  array(string) lines = (Stdio.read_file(argv[1]) / "\n") - ({""});
  int sum1 = 0;
  int sum2 = 0;
  foreach (lines, string line) {
    sum1 += (int) joltage(line, 2);
    sum2 += (int) joltage(line, 12);
  }
  write("Part 1: %d\n", sum1);
  write("Part 2: %d\n", sum2);
}
