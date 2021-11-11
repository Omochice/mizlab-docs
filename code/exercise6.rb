require "mizlab"
require "bio"
require "fileutils"
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
  accessions = ["U00096", "AL009126", "L43967", "CP000435", "AE009950"]
  FileUtils.mkdir("data") if !File.exists?("data")

  files = accessions.map { |acc| "data/#{acc}.gbk" }
  accessions.zip(files) do |accession, dst|
    if !File.exist?(dst)
      Mizlab.savefile(dst, Mizlab.getobj(accession))
    end
  end

  files.each do |f|
    Bio::FlatFile.auto(f).each_entry do |e|
      freq = []
      e.seq.window_search(1000, 1000) do |window|
        composition = window.split("").tally
        composition.default = 0
        c = composition["c"] + composition["C"]
        g = composition["g"] + composition["G"]
        freq << (c - g) / (c + g).to_f
      end
      GR.plot(Array.new(freq.length) { |i| i },
              freq,
              ylabel: "GC skew",
              xlabel: "Window",
              title: "#{e.organism}",
              font: "times_italic")
      GR.savefig("#{e.accession}.pdf")
      GR.plot(Array.new(freq.length) { |i| i },
              freq.accumulate,
              ylabel: "Cumulative GC skew",
              xlabel: "Window",
              title: "#{e.organism}",
              font: "times_italic")
      GR.savefig("#{e.accession}_cumulative.pdf")
    end
  end
end
