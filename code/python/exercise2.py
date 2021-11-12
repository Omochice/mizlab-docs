import collections
from pathlib import Path

from Bio import Entrez, SeqIO

if __name__ == "__main__":
    accessions = [
        "U01317",
        "M15387",
        "J03643",
        "V00409",
        "M15734",
        "V00722",
        "V00882",
        "X06701",
        "X61109",
        "X00376",
        "X02345",
    ]

    # download
    data_dst = Path(__file__).resolve().parents[1] / "data"
    data_dst.mkdir(parents=True, exist_ok=True)
    files = list(map(lambda x: data_dst / (x + ".gbk"), accessions))
    not_exists = list(filter(lambda f: not f.exists(), files))
    Entrez.email = "your_addres@example.com"
    if not_exists:
        with Entrez.efetch(
            db="nucleotide",
            id=list(map(lambda f: f.stem, not_exists)),
            rettype="gb",
            retmode="text",
        ) as handle:
            for entry, dst in zip(SeqIO.parse(handle, "genbank"), not_exists):
                with dst.open("w") as f:
                    SeqIO.write(entry, f, "genbank")

    # make table
    table = [["アクセッション番号", "生物種名", "生成物", "配列長", "GC含有"]]
    for f in files:
        for entry in SeqIO.parse(f, "genbank"):
            counter = collections.Counter(entry.seq)
            table.append(
                [
                    entry.annotations["accessions"][0],
                    entry.annotations["organism"],
                    entry.annotations["source"],
                    len(entry.seq),
                    (counter["G"] + counter["C"]) / len(entry.seq) * 100,
                ]
            )

    # stdout
    for row in table:
        print("\t".join(map(str, row)))
