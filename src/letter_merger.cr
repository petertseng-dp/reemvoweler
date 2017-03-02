class LetterMerger
  def initialize(words : Enumerable(String))
    @words = Set(String).new(words)
    # Too lazy to make and use a Trie...
    @prefixes = Set(String).new(words.flat_map { |w| (0..w.size).map { |s| w[0..s] } })
  end

  def merge(letters : Array(String), prefix = "") : Array(Array(String))
    if letters.all?(&.empty?)
      return [[] of String] if prefix.empty?
      return @words.includes?(prefix) ? [[prefix]] : [] of Array(String)
    end

    (0...letters.size).flat_map { |i| try_append(letters, i, prefix) } + try_new_word(letters, prefix)
  end

  private def try_append(letters : Array(String), i : Int32, prefix : String) : Array(Array(String))
    return [] of Array(String) if letters[i].empty?
    new_prefix = prefix + letters[i][0]
    return [] of Array(String) unless @prefixes.includes?(new_prefix)
    merge(letters.map_with_index { |l, j| i == j ? l[1..-1] : l }, new_prefix)
  end

  private def try_new_word(letters : Array(String), prefix : String) : Array(Array(String))
    return [] of Array(String) if prefix.empty? || !@words.includes?(prefix)
    merge(letters, "").map { |words| [prefix] + words }
  end
end
