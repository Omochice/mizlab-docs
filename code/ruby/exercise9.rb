require "mizlab"
require "bio"
require "numo/gnuplot"

def correlation_coefficient(x, y)
  x_ave = x.sum / x.length.to_f
  y_ave = y.sum / y.length.to_f
  # cov = x.zip(y).inject(0) { |c, a| c += (a[0] - x_ave) * (a[1] - y_ave) }
  cov = x.zip(y).map { |xi, yi| (xi - x_ave) * (yi - y_ave) }.sum
  x_rho = x.map { |xi| (xi - x_ave) ** 2 }.sum
  y_rho = y.map { |yi| (yi - y_ave) ** 2 }.sum
  return cov / (x_rho ** 0.5 * y_rho ** 0.5)
end

if $0 == __FILE__
  accessions = ["U00096", "AE005174"]
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
      e.seq.window_search(8, 1) do |window|
        counter[window] += 1
      end
      freqs << counter
    end
  end

  # plot
  table = [["Definition", "correlation"]]
  keys = []
  freqs[0].sort_by { |_, v| -v }.each do |k, _|
    keys << k
  end

  freqs.zip(names, accessions) do |freq, name, acc|
    x = []
    y = []
    keys.each do |k|
      c = Bio::Sequence::NA.new(k).complement
      if freq.include?(k) && freq.include?(c)
        x << freq[k]
        y << freq[c]
      end
    end
    Numo.gnuplot do
      set terminal: { png: { size: [640, 640], font: ",16" } }
      set :nokey
      set title: "{/Arial-Italic #{name}}" # BUG: "Italic" not work
      set xlabel: "Word Count"
      set ylabel: "Complementary Word Count"
      set output: "#{acc}.png"
      plot x, y, { pt: 7, ps: 0.5 }
    end
    table << [name, correlation_coefficient(x, y)]
  end

  # stdout
  table.each do |row|
    puts(row.join("\t"))
  end
end
