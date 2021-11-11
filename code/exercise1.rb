require "mizlab"
require "bio"
require "fileutils"

if $0 == __FILE__
  accessions = ["U01317", "M15387", "J03643", "V00409", "M15734",
                "V00722", "V00882", "X06701", "X61109", "X00376", "X02345"]

  destination = "data"
  if !File.exists?(destination)
    FileUtils.mkdir(destination)
  end

  table = [["アクセッション番号", "生物種名", "生成物", "配列長", "GC含有"]]
  accessions.each do |accession|
    object = Mizlab.getobj(accession)
    Mizlab.savefile("#{destination}/#{accession}.gbk", object)
    table << [accession, object.organism, object.definition,
              object.seq.length, object.seq.gc_percent]
  end

  File.open("result.tsv", "w") do |fp|
    table.each do |row|
      fp.puts(row.join("\t"))
    end
  end
end
