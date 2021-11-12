require "mizlab"
require "bio"
require "numo/gnuplot"

# Get random words
# @param  [Integer] word_length Length of each words
# @param  [Integer] n_words Number of words
# @return [Array] Words
def get_random_words(word_length, n_words)
  base = ["a", "t", "g", "c"]
  words = []
  while words.length < 100 do
    word = ""
    10.times do
      word += base.sample
    end
    words << word unless words.include?(word)
  end
  return words
end

if $0 == __FILE__
  accessions = ["U00096", "AE005174", "AL590842"]
  data_dst = File.join(File.dirname(Dir.pwd), "data")

  # download
  not_exists = accessions.filter { |acc| !File.exist?(File.join(data_dst, "#{acc}.gbk")) }
  unless not_exists.empty?
    Mizlab.getobj(not_exists) do |e|
      Mizlab.savefile(File.join(data_dst, "#{e.accession}.gbk"), e)
    end
  end

  # analysis
  files = accessions.map { |acc| File.join(data_dst, "#{acc}.gbk") }
  names = []
  freqs = []
  files.each do |f|
    Bio::FlatFile.auto(f).each_entry do |e|
      counter = Hash.new(0)
      names << e.organism
      e.seq.window_search(10, 1) do |window|
        counter[window] += 1
      end
      freqs << counter
    end
  end

  # plot
  keys = get_random_words(10, 100)

  freqs.zip(names, accessions) do |freq, name, acc|
    values = []
    keys.each do |k|
      values << freq[k]
    end
    Numo.gnuplot do
      set terminal: "pdf"
      set :nokey
      set title: "{/Arial-Italic #{name}}"
      set ylabel: "Frequency"
      set xlabel: "Word"
      set output: "#{acc}.pdf"
      plot Array.new(values.length) { |i| i }, values, with: "line"
    end
  end
end
