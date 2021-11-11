require "bio"

if $0 == __FILE__
  frequencies = {}
  file = ARGV[0]
  Bio::FlatFile.auto(file).each_entry do |entry|
    frequencies.merge!(entry.seq.composition) { |_, v_org, v_new| v_org + v_new }
  end
  sum_of_freq = frequencies.values.sum

  table = []
  table <<  ["アミノ酸", "", "出現頻度", ""]
  table << ["3文字コード", "1文字コード", "絶対数", "%"]
  frequencies.sort_by { |k, v| -v }.each do |amino, amount|
    code = Bio::Sequence::AA.new(amino).codes[0] # codes return array
    table << [code, amino, amount, amount / sum_of_freq.to_f * 100]
  end

  # File.open("results.tsv") do |tsv| # If output to file, use tsv.puts instead of put
  table.each do |row|
    puts row.join("\t")
  end
  # end
end
