require "mizlab"
require "numo/gnuplot"
require "gr/plot"

class Array
  def accumulate
    sum = 0
    accumulated = []
    self.each do |c|
      sum += c
      accumulated << sum
    end
    return accumulated
  end
end

if $0 == __FILE__
  accessions = ["U00096", "AL009126", "CP000435", "AE009950"]
  data_dst = File.join(File.dirname(Dir.pwd), "data")

  # download
  not_exists = accessions.filter { |acc| !File.exist?(File.join(data_dst, "#{acc}.gbk")) }
  unless not_exists.empty?
    Mizlab.getobj(not_exists) do |entry|
      Mizlab.savefile(File.join(data_dst, "#{entry.accession}.gbk"))
    end
  end

  # analysis
  files = accessions.map { |acc| File.join(data_dst, "#{acc}.gbk") }
  files.each do |f|
    Bio::FlatFile.auto(f).each_entry do |entry|
      skews = []
      entry.seq.window_search(1000, 1000) do |window|
        p window.class
        counter = window.split("").tally  # NOTE: window_serach return string
        counter.default = 0
        c = counter["c"] + counter["C"]
        g = counter["g"] + counter["G"]
        skews << (c - g) / (c + g).to_f
      end
      Numo.gnuplot do
        set terminal: "pdf"
        set :nokey
        set title: "{/Arial-Italic #{entry.organism}}"
        set ylabel: "GC skew"
        set xlabel: "Window"
        set output: "#{entry.accession}.pdf"
        plot Array.new(skews.length) { |i| i }, skews, with: "line"
      end
      Numo.gnuplot do
        set terminal: "pdf"
        set :nokey
        set title: "{/Arial-Italic #{entry.organism}}"
        set ylabel: "Cumulative GC skew"
        set xlabel: "Window"
        set output: "#{entry.accession}_cumulative.pdf"
        plot Array.new(skews.length) { |i| i }, skews.accumulate, with: "line"
      end
      # GR.plot(Array.new(skews.length) { |i| i },
      #         freq,
      #         ylabel: "GC skew",
      #         xlabel: "Window",
      #         title: "#{entry.organism}",
      #         font: "times_italic")
      # GR.savefig("#{entry.accession}.pdf")
      # GR.plot(Array.new(skews.length) { |i| i },
      #         freq.accumulate,
      #         ylabel: "Cumulative GC skew",
      #         xlabel: "Window",
      #         title: "#{entry.organism}",
      #         font: "times_italic")
      # GR.savefig("#{entry.accession}_cumulative.pdf")
    end
  end
end
