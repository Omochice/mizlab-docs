require "bio"

if $0 == __FILE__
  n_entries = 0
  n_bases = 0
  square_n_bases = 0
  max_len = 0
  min_len = Float::INFINITY
  entry_has_max_seq = nil
  entry_has_min_seq = nil

  file = ARGV[0]
  Bio::FlatFile.auto(file).each_entry do |entry|
    n_entries += 1
    n_bases += entry.seq.length  # entry.lengthでも取れるけど直感的じゃない気がする
    square_n_bases += entry.seq.length ** 2
    if entry.seq.length < min_len
      min_len = entry.seq.length
      entry_has_min_seq = entry
    end
    if entry.seq.length > max_len
      max_len = entry.seq.length
      entry_has_max_seq = entry
    end
  end
  n_entries = n_entries.to_f
  sd = Math.sqrt((square_n_bases / n_entries) - (n_bases / n_entries) ** 2)

  puts "SD:\t#{sd}"
  puts "Number of entries:\t#{n_entries.to_i}"
  puts "Sum of all bases:\t#{n_bases}"
  puts "Entry that has max number of bases: #{entry_has_max_seq.accession} (#{max_len} beses)"
  puts "\t#{entry_has_max_seq.definition}"
  puts "Entry that has min number of bases: #{entry_has_min_seq.accession} (#{min_len} beses)"
  puts "\t#{entry_has_min_seq.definition}"
end
