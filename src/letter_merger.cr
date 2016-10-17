class LetterMerger
  def initialize(words : Enumerable(String))
    @words = Set(String).new(words)
    # Too lazy to make and use a Trie...
    @prefixes = Set(String).new(words.flat_map { |w| (0..w.size).map { |s| w[0..s] } })
  end

  def merge(letters : Array(Array(Char)), prefix = [] of Char) : Array(Array(String))
    if letters.all?(&.empty?)
      return [[] of String] if prefix.empty?
      word = prefix.join
      return @words.includes?(word) ? [[word]] : [] of Array(String)
    end

    (0...letters.size).flat_map { |i| try_append(letters, i, prefix) } + try_new_word(letters, prefix)
  end

  private def try_append(letters : Array(Array(Char)), i : Int32, prefix : Array(Char)) : Array(Array(String))
    return [] of Array(String) if letters[i].empty?
    new_prefix = prefix + [letters[i][0]]
    return [] of Array(String) unless @prefixes.includes?(new_prefix.join)
    merge(letters.map_with_index { |l, j| i == j ? l[1..-1] : l }, new_prefix)
  end

  private def try_new_word(letters : Array(Array(Char)), prefix : Array(Char)) : Array(Array(String))
    word = prefix.join
    return [] of Array(String) if word.empty? || !@words.includes?(word)
    merge(letters, [] of Char).map { |words| [word] + words }
  end
end
