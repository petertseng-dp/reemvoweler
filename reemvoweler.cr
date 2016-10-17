require "./src/letter_merger"

# Some of the short words are super weird. I don't want them.
# There were 26 of these, pare them down to 2.
ONE_LETTERS = Set.new(%w(a i))
# There were 486 of these in words, 135 in cracklib-small, pare them down to 42.
TWO_LETTERS = Set.new(%w(
  ah
  an
  as
  at
  aw
  ax
  be
  bi
  by
  do
  eh
  ex
  go
  ha
  he
  if
  in
  is
  it
  ma
  me
  my
  no
  of
  oh
  on
  op
  or
  ow
  ox
  oy
  pa
  so
  to
  uh
  um
  up
  us
  we
  ya
  ye
  yo
))
LETTERS = [nil, ONE_LETTERS, TWO_LETTERS]

words = File.read_lines("/usr/share/cracklib/cracklib-small").map(&.chomp).reject { |w|
  letters = LETTERS[w.size]?
  letters && !letters.includes?(w)
}

list = LetterMerger.new(words, ARGV.map(&.chars)).merge
list.sort_by { |x| x.map(&.size).sort.reverse }.each { |l| puts l.join(' ') }
