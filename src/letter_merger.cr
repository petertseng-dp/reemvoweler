class LetterMerger
  def initialize(words : Enumerable(String), @letters : Array(Array(Char)))
    @words = Set(String).new(words)
    # Too lazy to make and use a Trie...
    @prefixes = Set(String).new(words.flat_map { |w| (0..w.size).map { |s| w[0..s] } })
  end

  def merge : Array(Array(String))
    internal_merge(@letters.map { |c| 0_u32 })
  end

  def internal_merge(positions : Array(UInt32), prefix = [] of Char) : Array(Array(String))
    if positions.zip(@letters).all? { |i, c| i == c.size }
      return [[] of String] if prefix.empty?
      word = prefix.join
      return @words.includes?(word) ? [[word]] : [] of Array(String)
    end

    (0...positions.size).flat_map { |i| try_append(positions, i, prefix) } + try_new_word(positions, prefix)
  end

  private def try_append(positions : Array(UInt32), i : Int32, prefix : Array(Char)) : Array(Array(String))
    return [] of Array(String) if positions[i] == @letters[i].size
    new_prefix = prefix + [@letters[i][positions[i]]]
    return [] of Array(String) unless @prefixes.includes?(new_prefix.join)
    internal_merge(positions.map_with_index { |p, j| i == j ? p + 1 : p }, new_prefix)
  end

  private def try_new_word(positions : Array(UInt32), prefix : Array(Char)) : Array(Array(String))
    word = prefix.join
    return [] of Array(String) if word.empty? || !@words.includes?(word)
    internal_merge(positions, [] of Char).map { |words| [word] + words }
  end
end
