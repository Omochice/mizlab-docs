require "bio"

if $0 == __FILE__
  file = ARGV[0]

  data = []
  Bio::FlatFile.auto(file).each_entry do |e|
    data << e.seq.gc_percent  # gc_percent return Integer
    # composition = e.seq.composition
    # composition.default = 0
    # gc_amount = composition["g"] + composition["G"] + composition["c"] + composition["C"]
    # data << gc_amount / composition.values.sum.to_f * 100
  end

  # # for gnuplot
  # results = Array.new(20, 0) # results has frequencies that is splited each 5%
  # data.each do |freq|
  #   results[freq.to_i / 5] += 1
  # end
  # results.each_with_index() do |c, i|
  #   puts "#{(i+1)*5} #{c}"
  # end

  # for GR.rb
  require "gr/plot"
  GR.histogram(data,
               nbins: 5,
               xlabel: "GC contents (%)",
               ylabel: "Frequency",
               xticks: [5, 2],
               xlim: [0, 100])
  GR.savefig("exercise5.pdf")

  # # for numo-gnuplot
  # require "numo/gnuplot"
  # Numo.gnuplot do
  #   set terminal: "pdf"
  #   set :nokey
  #   set ylabel: "Frequency"
  #   set xlabel: "GC Contents (%)"
  #   set output: "numo.pdf"
  #   set :style, fill: { solid: 0.5 }
  #   plot Array.new(20) { |i| i * 5 + 2.5 }, results, with: "boxes"
  #   # NOTE: 0, 5...をbarの中心にしようとするのでずらす
  # end
end
