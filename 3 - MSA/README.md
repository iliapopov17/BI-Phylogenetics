# Multiple sequence alignment

- `phylo-3.ipynb` - contains this whole pipeline done

> For this work, we will use the alignments of [SUP35 gene](https://www.yeastgenome.org/locus/S000002579)

### 1) Commands to run 6 possible alignment algorithms (`clustalw`, `muscle`, `mafft`, `kalign`, `tcoffee`, `prank`) for 10 DNA sequences.

**_Input_**

```bash
time clustalw -INFILE=data/SUP35_10seqs.fa -OUTPUT=FASTA -OUTFILE=10_DNA_seqs/02_SUP35_10seqs.clustalw.fa
time muscle -align data/SUP35_10seqs.fa -output 10_DNA_seqs/02_SUP35_10seqs_muscle.fa
time mafft --auto data/SUP35_10seqs.fa >10_DNA_seqs/02_SUP35_10seqs_mafft.fa
time kalign <data/SUP35_10seqs.fa >10_DNA_seqs/02_SUP35_10seqs_kalign.fa
time t_coffee -infile=data/SUP35_10seqs.fa -outfile=10_DNA_seqs/02_SUP35_10seqs_tcoffee.fa -output=fasta_aln
time prank -d=data/SUP35_10seqs.fa -o=10_DNA_seqs/02_SUP35_10seqs_prank.fa -codon
```

**_Input_**

```python
from Bio import AlignIO
import os
```

**_Input_**

```python
folder_path = '10_DNA_seqs'
alignment_files = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.fa')]

for file in alignment_files:
    alignment = AlignIO.read(file, 'fasta')
    alignment_length = alignment.get_alignment_length()
    print(f"Alignment length in file {file}: {alignment_length}")
```

**_Output_**

```
Alignment length in file 10_DNA_seqs/02_SUP35_10seqs_tcoffee.fa: 2210
Alignment length in file 10_DNA_seqs/02_SUP35_10seqs_mafft.fa: 2166
Alignment length in file 10_DNA_seqs/02_SUP35_10seqs.clustalw.fa: 2148
Alignment length in file 10_DNA_seqs/02_SUP35_10seqs_kalign.fa: 2152
Alignment length in file 10_DNA_seqs/02_SUP35_10seqs_muscle.fa: 2333
```

### 2) Comparative table with running time and DNA alignment quality for the algorithms used above
> Which algorithm is better to use?

|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|5.641|2148|
|muscle|5.009|2333|
|mafft|4.382|2166|
|kalign|0.475|2152|
|t_coffee|20.869|2210|
|prank|more than 10 minutes|NA|

I think it's best to use `muscle` as it got the longest expressing length! (Of course alignment length is not the only quality metric, but I used this metric only in this study project.)

### 3) What's wrong with the alignment of `SUP35_10seqs_strange_aln.fa` and how to fix it?

Let's take a look at this alignment in UGENE

<div style='justify-content: center'>
<img src="https://github.com/iliapopov17/BI-Phylogenetics/blob/main/3%20-%20MSA/imgs/1.png" align='center', width="50%">
</div>

It can be seen that the sequence `SUP35_Spar_A12_Liti_` is strange. Most likely it is a reverse, i.e. it is reverse complementary.

Let's do a couple of youtz, youtz, youtz, youtz.

<div style='justify-content: center'>
<img src="https://github.com/iliapopov17/BI-Phylogenetics/blob/main/3%20-%20MSA/imgs/2.png" align='center', width="50%">
</div>

<div style='justify-content: center'>
<img src="https://github.com/iliapopov17/BI-Phylogenetics/blob/main/3%20-%20MSA/imgs/3.png" align='center', width="50%">
</div>

It's beautiful!

### 4) Commands to run 6 possible alignments for 250 DNA sequences.

**_Input_**

```bash
time clustalw -INFILE=data/SUP35_250seqs.fa -OUTPUT=FASTA -OUTFILE=250_DNA_seqs/05_SUP35_250seqs.clustalw.fa
time muscle -align data/SUP35_250seqs.fa -output 250_DNA_seqs/05_SUP35_250seqs_muscle.fa
time mafft --auto data/SUP35_250seqs.fa >250_DNA_seqs/05_SUP35_250seqs_mafft.fa
time kalign <data/SUP35_250seqs.fa >250_DNA_seqs/05_SUP35_250seqs_kalign.fa
time t_coffee -infile=data/SUP35_250seqs.fa -outfile=250_DNA_seqs/05_SUP35_250seqs_tcoffee.fa -output=fasta_aln
time prank -d=data/SUP35_250seqs.fa -o=250_DNA_seqs/05_SUP35_250seqs_prank.fa -codon
```

**_Input_**

```python
folder_path = '250_DNA_seqs'
alignment_files = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.fa')]

for file in alignment_files:
    alignment = AlignIO.read(file, 'fasta')
    alignment_length = alignment.get_alignment_length()
    print(f"Alignment length in file {file}: {alignment_length}")
```

**_Output_**

```
Alignment length in file 250_DNA_seqs/05_SUP35_250seqs.clustalw.fa: 2179
Alignment length in file 250_DNA_seqs/05_SUP35_250seqs_mafft.fa: 2322
Alignment length in file 250_DNA_seqs/05_SUP35_250seqs_muscle.fa: 2365
Alignment length in file 250_DNA_seqs/05_SUP35_250seqs_kalign.fa: 2210
```

### 5) Comparative table with running time and DNA alignment quality for the algorithms used above
> Has our choice of algorithm changed?

|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|48:41.97|2179|
|muscle|30:44.42|2365|
|mafft|41.962|2322|
|kalign|7.996|2210|
|t_coffee|more than 1 hour|NA|
|prank|more than 1 hour|NA|

All my sympathies are on the side of `kalign` for the reason that it aligned 250 sequences in 8 seconds.
But to be fair, `mafft` is not bad either. Its alignment is longer, and its working time is 42 seconds, not 30 or 48 minutes....

### 6) How to get amino acid sequences (translate)?

**Option 1 - `transeq`**

The simplest and fastest variant. With its help, we "stupidly" do the translation starting from the first nucleotide and up to the last one.

**_Input_**

```bash
transeq -sequence data/<file_name>.fa -outseq data/<file_name>.t.faa
```

**Option 2 - `getorf`**

Based on the assumption that he was given a sequence that has an open reading frame.
He is not highly intelligent.
Anything that starts with a methionine and ends with a stop codon is an open reading frame!
It needs to tune our representation, otherwise we get a bunch of junk. Especially in fairly long sequences.
But if we know how long this junk should be and we need to predict proteins quickly from our data of some Sanger sequencing, it is a very good option!

**_Input_**

```bash
getorf -sequence data/<file_name>.fa -outseq data/<file_name>.g.faa -noreverse -minsize 500
```

### 7) Commands to run 6 possible alignment variants for 10 protein sequences.

**_Input_**

```bash
time clustalw -INFILE=data/SUP35_10seqs.g.faa -OUTFILE=10_protein_seqs/08_SUP35_10seqs.clustalw.faa -OUTPUT=FASTA -TYPE=protein
time clustalo --infile=data/SUP35_10seqs.g.faa --outfile=10_protein_seqs/08_SUP35_10seqs.clustalo.faa --verbose
time muscle -align data/SUP35_10seqs.g.faa -output 10_protein_seqs/08_SUP35_10seqs_muscle.faa
time mafft --auto data/SUP35_10seqs.g.faa >10_protein_seqs/08_SUP35_250seqs_mafft.fa
time kalign <data/SUP35_10seqs.g.faa >10_protein_seqs/08_SUP35_10seqs_kalign.faa
time t_coffee -infile=data/SUP35_10seqs.g.faa -outfile=10_protein_seqs/08_SUP35_10seqs_tcoffee.faa -output=fasta_aln
time prank -d=data/SUP35_10seqs.g.faa -o=10_protein_seqs/08_SUP35_10seqs_prank.faa
```

**_Input_**

```python
folder_path = '10_protein_seqs'
alignment_files = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.fa') | file.endswith('.faa') | file.endswith('.fas')]

for file in alignment_files:
    alignment = AlignIO.read(file, 'fasta')
    alignment_length = alignment.get_alignment_length()
    print(f"Alignment length in file {file}: {alignment_length}")
```

**_Output_**

```
Alignment length in file 10_protein_seqs/08_SUP35_250seqs_mafft.fa: 759
Alignment length in file 10_protein_seqs/08_SUP35_10seqs_muscle.faa: 765
Alignment length in file 10_protein_seqs/08_SUP35_10seqs_kalign.faa: 721
Alignment length in file 10_protein_seqs/08_SUP35_10seqs_tcoffee.faa: 752
Alignment length in file 10_protein_seqs/08_SUP35_10seqs.clustalw.faa: 719
Alignment length in file 10_protein_seqs/08_SUP35_10seqs.clustalo.faa: 757
Alignment length in file 10_protein_seqs/08_SUP35_10seqs_prank.faa.best.fas: 776
```

### 8) Comparative table with running time of protein alignments
> What is the best algorithm to use?


|Tool|Time|Alignment length|
|----|----|----------------|
|clustalw|0.684|719|
|clustalo|0.742|757|
|muscle|0.582|765|
|mafft|0.754|759|
|kalign|0.062|721|
|t_coffee|2.697|752|
|prank|4:50.84|776|

This is where I like `muscle` the best. It worked for less than 1 second and its expressing length is quite respectable.

### 9) How to add two more nucleotide sequences to an alignment of 250 nucleotide sequences, previously aligning them, with and `mafft`?

**_Input_**

```bash
mafft --auto data/<file_name>.fa > 252_DNA_seqs/<file_name>_mafft.fa
mafft --add 252_DNA_seqs/<file_name>_mafft.fa 250_DNA_seqs/<file_name>_mafft.fa > 252_DNA_seqs/<file_name>_mafft.fa
```

### 10) Extract from NCBI using any variation of eutils all sequences for the query "Parapallasea 18S" (Parapallasea is a taxon and 18S is a gene) and save to the file fasta.
> What goes wrong when aligning the sequences in the Parapallasea_18S.fa file and with what parameters can you get the correct answer?

**_Input_**

```bash
esearch -db nucleotide -query "Parapallasea 18S" | efetch -format fasta >Parapallasea_18.fa
```

**Option 1 - `muscle`**

**_Input_**

```bash
muscle -align Parapallasea_18.fa -output Parapallasea_18.fa.muscle.aln
```

`muscle` worked very well for me. At the lecture we discussed that:

- 18S sequenced in chunks
- One sequence is long - a complete gene
- Three short sequences:
  - In two cases, the beginning of the gene was sequenced
  - In one case - the end of the gene
- **The sequences overlap little, partially.**

And at the lecture, muscle broke down slightly. `muscle' put the third sequence in an even layer, even though it should be at the end. He put a piece of it at the beginning, and a piece of it at the end, where it actually aligns.

But I had muscle aligned it fine. The end of the gene went to the end, the beginning went to the beginning. See the screenshot below. Probably in the new version `muscle` has learnt to handle such sequences well. Nevertheless, I legitimate that with partially overlapping sequences it is better to try different algorithms, and `mafft` and `prank` were better than `muscle` at one time.

<div style='justify-content: center'>
<img src="https://github.com/iliapopov17/BI-Phylogenetics/blob/main/3%20-%20MSA/imgs/4.png" align='center', width="50%">
</div>

The beginning of a gene

<div style='justify-content: center'>
<img src="https://github.com/iliapopov17/BI-Phylogenetics/blob/main/3%20-%20MSA/imgs/5.png" align='center', width="50%">
</div>

The end of the gene<br>

**Option 2 - `mafft`**

**_Input_**

```bash
mafft --auto Parapallasea_18.fa > Parapallasea_18.fa.mafft.aln
```

### 11) Commands for creating a blast database from a set of Ommatogammarus_flavus_transcriptome_assembly.fa sequences, and for searching this database for the protein sequence Acanthogammarus_victorii_COI.faa and recording the results in a table (tab-separated text).
> Attention: the origin of the sequence is mitochondrial. What is important to consider when searching?
Extract the sequence with the best match into a separate file.

**_Input_**

```bash
makeblastdb -in data/Ommatogammarus_flavus_transcriptome_assembly.fa -dbtype nucl -parse_seqids
```

The gene is mitochondrial<br>
Accordingly, the genetic code is different, and since here we are dealing with the communication between the protein query and the nucleotide base, it may matter. Not catastrophic here. But it is better to use the `-db_gencode 5` option, because this way the identity will be higher

**_Input_**

```bash
tblastn -query data/Acanthogammarus_victorii_COI.faa -db data/Ommatogammarus_flavus_transcriptome_assembly.fa -outfmt 6 -db_gencode 5
## fields: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore
```

**_Output_**

```
Acanthogammarus_victorii_COI	TRINITY_DN8878_c0_g1_i2	89.621	501	52	0	9	509	3	1505	0.0	781
Acanthogammarus_victorii_COI	TRINITY_DN58613_c0_g1_i1	50.000	20	9	1	206	225	32	88	6.3	20.8
```

Percentage of identity is **89.621**! Yay!

**_Input_**

```bash
blastdbcmd -db data/Ommatogammarus_flavus_transcriptome_assembly.fa -entry TRINITY_DN8878_c0_g1_i2 -out data/Ommatogammarus_flavus_COI.fa
```

**_Input_**

```bash
cat data/Ommatogammarus_flavus_COI.fa
```

**_Output_**

```
>TRINITY_DN8878_c0_g1_i2 len=1505
CGACCAACCACAAAGATATTGGCACTCTTTATTTTATGCTAGGGCTCTGGTCTGGGTTAGTCGGAACCTCCATAAGACTT
ATCCTCCGCTCAGAACTTAGTGCGCCGGGTAGCCTGATTGGTGATGATCAACTGTATAACGTAATGGTAACCTCCCATGC
TTTTATTATAATTTTTTTTATAGTTATGCCTATCATAATTGGCGGGTTTGGTAACTGGCTGCTTCCTTTAATACTAGGTA
GACCTGATATAGCCTTCCCTCGAATAAACAACATGAGCTTTTGACTACTACCTCCTTCCCTTACACTTCTTATATCTAGA
AGCTTAGTAGAAAGAGGAGTCGGCACAGGTTGAACTGTCTACCCTCCTTTATCTGGGTCTACAGCCCATAGAGGTAGCGC
TGTAGATTTGGCTATTTTCTCACTTCATTTAGCCGGAGCTTCCTCTATCTTAGGGGCTGTAAATTTTATTTCTACCGCCA
TTAATATGCGAGCGCCTGGGATAAAATTAGACCAAATGCCTTTATTCGTCTGAGCTATTATTATTACTACCGTCCTCCTA
GTCTTATCCCTACCAGTCCTAGCTGGGGCCATTACGATACTACTTACAGACCGTAACATAAATACCTCTTTTTTTGACCC
TAGTGGGGGGGGTGACCCTATCCTATACCAACACTTATTTTGATTTTTTGGGCACCCAGAGGTGTATATTTTAATCCTGC
CTGCATTTGGCATAATCTCTCATATTGTTAGACAGGAGTCCGGTAAAAAAGAAACATTTGGCCCCCTAGGGATAATTTAT
GCTATATTAGCTATTGGGTTCCTCGGATTTATTGTGTGAGCCCATCATATGTTTACAGTCGGTATGGATGTAGATACCCG
AGCCTATTTTACATCAGCTACAATAATTATTGCAGTCCCCACCGGCATCAAAGTATTTAGGTGACTAGGTACTCTACAAG
GCGGAAAAATTAACTTTTCTCCAGCTCTAATTTGAAGACTAGGTTTTATTTTCCTTTTCTCTATTGGAGGTTTAACTGGA
GTTATATTAGCTAACTCATCAATTGACATCGTACTACACGACACTTACTATGTAGTTGCCCACTTTCATTATGTTTTATC
TATGGGGGCTGTTTTCGGTATTTTTGCGGGGTTTGCTTACTGGTTTCCACTATTTACAGGTATAACTATCAATCCTATCC
TAGCTAAAATTCATTTTTACGTCATATTCATGGGAGTAAACTTAACTTTTTTCCCCCAACATTTCCTTGGTTTAACGGGC
ATACCTCGGCGATACTCAGACTATCCTGACTTCTTCACAGCCTGAAATATTGTTTCCTCCTTAGGCTCTTATATCTCTGT
TTTAGCTATAGTGATCTTTATTGCTATAATCATAGAAGCTTTTATCTCTAAGCGGTCCGCTTTATTTTCCTTAACCTTGT
CGTCTGCTTTAGAGTGGTACCACTCATACCCGCCAGCCGACCATAGCTACAACGATACCCCTATT
```
