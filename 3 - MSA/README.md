# Multiple sequence alignment

- `phylo-3.ipynb` - contains this whole pipeline done with more steps and visualisation

1) Commands to run 6 possible alignment algorithms (`clustalw`, `muscle`, `mafft`, `kalign`, `tcoffee`, `prank`) for 10 DNA sequences.

```bash
time clustalw -INFILE=data/<file_name>.fa -OUTPUT=FASTA -OUTFILE=10_DNA_seqs/<file_name>.clustalw.fa
time muscle -align data/<file_name>.fa -output 10_DNA_seqs/<file_name>_muscle.fa
time mafft --auto data/<file_name>.fa >10_DNA_seqs/<file_name>_mafft.fa
time kalign <data/<file_name>.fa >10_DNA_seqs/<file_name>_kalign.fa
time t_coffee -infile=data/<file_name>.fa -outfile=10_DNA_seqs/<file_name>_tcoffee.fa -output=fasta_aln
time prank -d=data/<file_name>.fa -o=10_DNA_seqs/<file_name>_prank.fa -codon
```

2) Comparative table with running time and DNA alignment quality for the algorithms used above

|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|5.641|2148|
|muscle|5.009|2333|
|mafft|4.382|2166|
|kalign|0.475|2152|
|t_coffee|20.869|2210|
|prank|more than 10 minutes|NA|


3) Commands to run 6 possible alignments for 250 DNA sequences.

```bash
time clustalw -INFILE=data/<file_name>.fa -OUTPUT=FASTA -OUTFILE=250_DNA_seqs/<file_name>.clustalw.fa
time muscle -align data/<file_name>.fa -output 250_DNA_seqs/<file_name>_muscle.fa
time mafft --auto data/<file_name>.fa >250_DNA_seqs/<file_name>_mafft.fa
time kalign <data/<file_name>.fa >250_DNA_seqs/<file_name>_kalign.fa
time t_coffee -infile=data/<file_name>.fa -outfile=250_DNA_seqs/<file_name>_tcoffee.fa -output=fasta_aln
time prank -d=data/<file_name>.fa -o=250_DNA_seqs/<file_name>_prank.fa -codon
```

4) Comparative table with running time and DNA alignment quality for the algorithms used above

|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|48:41.97|2179|
|muscle|30:44.42|2365|
|mafft|41.962|2322|
|kalign|7.996|2210|
|t_coffee|more than 1 hour|NA|
|prank|more than 1 hour|NA|

4) How to get amino acid sequences (translate)?

**Option 1 - `transeq`**

The simplest and fastest variant. With its help, we "stupidly" do the translation starting from the first nucleotide and up to the last one.

```bash
transeq -sequence data/<file_name>.fa -outseq data/<file_name>.t.faa
```

**Option 2 - `getorf`**

Based on the assumption that he was given a sequence that has an open reading frame.
He is not highly intelligent.
Anything that starts with a methionine and ends with a stop codon is an open reading frame!
It needs to tune our representation, otherwise we get a bunch of junk. Especially in fairly long sequences.
But if we know how long this junk should be and we need to predict proteins quickly from our data of some Sanger sequencing, it is a very good option!

```bash
getorf -sequence data/<file_name>.fa -outseq data/<file_name>.g.faa -noreverse -minsize 500
```

5) Commands to run 6 possible alignment variants for 10 protein sequences.

```bash
time clustalw -INFILE=data/<file_name>.g.faa -OUTFILE=10_protein_seqs/<file_name>.clustalw.faa -OUTPUT=FASTA -TYPE=protein
time clustalo --infile=data/<file_name>.g.faa --outfile=10_protein_seqs/<file_name>.clustalo.faa --verbose
time muscle -align data/<file_name>.g.faa -output 10_protein_seqs/<file_name>_muscle.faa
time mafft --auto data/<file_name>.g.faa >10_protein_seqs/<file_name>_mafft.fa
time kalign <data/<file_name>.g.faa >10_protein_seqs/<file_name>_kalign.faa
time t_coffee -infile=data/<file_name>.g.faa -outfile=10_protein_seqs/<file_name>_tcoffee.faa -output=fasta_aln
time prank -d=data/<file_name>.g.faa -o=10_protein_seqs/<file_name>_prank.faa
```

6) Comparative table with running time of protein alignments


|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|0.684|719|
|clustalo|0.742|757|
|muscle|0.582|765|
|mafft|0.754|759|
|kalign|0.062|721|
|t_coffee|2.697|752|
|prank|4:50.84|776|

7) How to add two more nucleotide sequences to an alignment of 250 nucleotide sequences, previously aligning them, with and `mafft`?

```bash
mafft --auto data/<file_name>.fa > 252_DNA_seqs/<file_name>_mafft.fa
mafft --add 252_DNA_seqs/<file_name>_mafft.fa 250_DNA_seqs/<file_name>_mafft.fa > 252_DNA_seqs/<file_name>_mafft.fa
```
