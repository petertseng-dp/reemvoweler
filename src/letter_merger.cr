class LetterMerger
  def initialize(words : Enumerable(String))
    @words = Set(String).new(words)
    # Too lazy to make and use a Trie...
    @prefixes = Set(String).new(words.flat_map { |w| (0..w.size).map { |s| w[0..s] } })
  end

  def merge(letters : Array(Array(Char))) : Array(Array(String))
    internal_merge(letters.map { |c| {0_u32, c} })
  end

  def internal_merge(letters : Array(Tuple(UInt32, Array(Char))), prefix = [] of Char) : Array(Array(String))
    if letters.all? { |i, c| i == c.size }
      return [[] of String] if prefix.empty?
      word = prefix.join
      return @words.includes?(word) ? [[word]] : [] of Array(String)
    end

    (0...letters.size).flat_map { |i| try_append(letters, i, prefix) } + try_new_word(letters, prefix)
  end

  private def try_append(letters : Array(Tuple(UInt32, Array(Char))), i : Int32, prefix : Array(Char)) : Array(Array(String))
    li, l = letters[i]
    return [] of Array(String) if li == l.size
    new_prefix = prefix + [l[li]]
    return [] of Array(String) unless @prefixes.includes?(new_prefix.join)
    internal_merge(letters.map_with_index { |(li, l), j| {i == j ? li + 1 : li, l } }, new_prefix)
  end

  private def try_new_word(letters : Array(Tuple(UInt32, Array(Char))), prefix : Array(Char)) : Array(Array(String))
    word = prefix.join
    return [] of Array(String) if word.empty? || !@words.includes?(word)
    internal_merge(letters, [] of Char).map { |words| [word] + words }
  end
end
