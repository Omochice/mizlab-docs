require "bio"
require "mizlab"

# on this exercise, all used data is protein.
def download_if_not_exists(dst, acc)
  path = File.join(dst, "#{acc}.gbk")
  unless File.exist?(path)
    obj = Mizlab.getobj(acc, is_protein: true)
    Mizlab.savefile(path, obj)
  end
  return path
end

if $0 == __FILE__
  # Fetch data
  acc = "P78426"
  dst = File.join(File.dirname(Dir.pwd), "data")
  filepath = download_if_not_exists(dst, acc)

  table = [["Accession", "E-value", "Organism", "ProteinName", "FunctionOfProtein"]]
  seq = nil
  Bio::FlatFile.auto(filepath).each_entry do |e|
    table << [
      e.accession,
      0.0,
      e.organism,
      e.definition,
      e.comment.match(/\[FUNCTION\](.+)\n/).values_at(1).join.strip,
    ]
    seq = e.seq
  end

  # execute blast+
  factory = Mizlab::Blast.local("blastp", ARGV[0])
  factory.query(seq, { "-num_alignments" => 5, "-num_descriptions" => 5 }).each do |hit|
    splited = hit.definition.split("|")
    hit.accession = splited[1]
    path = download_if_not_exists(dst, hit.accession)
    Bio::FlatFile.auto(path).each_entry do |e|
      table << [
        e.accession,
        hit.evalue,
        e.organism,
        e.definition,
        e.comment.match(/\[FUNCTION\](.+)\n/).values_at(1).join.strip,
      ]
    end
  end

  table.each do |row|
    puts(row.join("\t"))
  end
end
