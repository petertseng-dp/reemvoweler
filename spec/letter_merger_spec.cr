require "spec"
require "../src/letter_merger"

describe LetterMerger do
  it "does Hotel Fate with one list" do
    words = %w(
      hot
      elf
      ate
      oh
      tea
      left
      eta
      eat
      hoe
      at
      left
      oh
      tel
      hotel
      fate
    )
    lm = LetterMerger.new(words)
    lm.merge(["hotelfate".chars]).sort.should eq([
      %w(hot elf ate),
      %w(hotel fate),
    ])
  end

  it "does Hotel Fate with two lists" do
    words = %w(
      hot
      elf
      ate
      oh
      tea
      left
      eta
      eat
      hoe
      at
      left
      oh
      tel
      hotel
      fate
    )
    lm = LetterMerger.new(words)
    lm.merge(["htlft", "oeae"].map(&.chars)).sort.should eq([
      %w(hoe at left),
      %w(hot elf ate),
      %w(hotel fate),
      %w(oh eat left),
      %w(oh eta left),
      %w(oh tea left),
      %w(oh tel fate),
    ])
  end

  it "finds anagrams" do
    words = %w(
      i
      am
      lord
      voldemort
    )
    lm = LetterMerger.new(words)
    lm.merge("tommarvoloriddle".chars.map { |c| [c] }).uniq { |l| Set.new(l) }.map(&.sort).should eq([
      # Voldemort has an identity crisis? "Am I Lord Voldemort?"
      %w(am i lord voldemort),
    ])
  end
end
