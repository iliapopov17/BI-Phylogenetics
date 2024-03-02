# Working with NCBI

## Part 1 - `Python`

```python
from Bio import Entrez
Entrez.email = 'iljapopov17@gmail.com'
```

1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

```python
handle = Entrez.esearch(db = "pubmed", term = "Cyclophilin A AND Open reading frame AND Real-time PCR")
record = Entrez.read(handle)
print(record)
mshandle = Entrez.efetch(db="pubmed", id=record["IdList"][0:2], rettype="abstract", retmode="text")
print(mshandle.read())
```

2) Find organism ID by name in the taxonomy database

```python
handle = Entrez.esearch(db = "taxonomy", term = "Procambarus clarkii") record = Entrez.read(handle)
print(record)
print(record['IdList'])
```

3) Query the nucleotide sequence database by gene name and return a table with UIDs

```python
handle = Entrez.esearch(db="nucleotide", term="cyclophilin AND Procambarus clarkii[orgn]")
record = Entrez.read(handle)
for rec in record["IdList"]:
        temphandle = Entrez.read(Entrez.esummary(db="nucleotide", id=rec, retmode="text"))
        print(temphandle[0]['Id']+"\t"+temphandle[0]['Caption']+"\t"+str(int(temphandle[0]['Length'])))#+"\n")
```

4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

```python
handle = Entrez.esearch(db="protein", term="cyclophilin AND Procambarus clarkii[orgn]")
record = Entrez.read(handle)
Entrez.efetch(db="protein", id=record["IdList"], retmode="text", rettype="fasta").read()
with open("cyclophilin.fasta", "w") as ouf:
    for rec in record["IdList"]:
        lne = Entrez.efetch(db="protein", id=rec, retmode="text", rettype="fasta").read()
        ouf.write(lne+"\n")
with open("cyclophilin.fasta", "r") as fastaf:
    snippet = [next(fastaf) for x in range(5)]
    print(snippet)
```

5) Download the protein corresponding to the known nucleotide UID

```python
lhandle = Entrez.elink(dbfrom="nucleotide", db="protein", id="429843488") 
lrecord = Entrez.read(lhandle)
prothandle = lrecord[0]["LinkSetDb"][0]['Link'][0]['Id']
rrecord = Entrez.efetch(db="protein", id=prothandle, rettype="fasta", retmode="text")
with open ("prot_from_nt.fasta", "w") as ouf:
    ouf.write(rrecord.read()+"\n")
with open("prot_from_nt.fasta", "r") as fastaf:
    snippet = [next(fastaf) for x in range(5)]
    print(snippet)
```

6) Download all sequences from the PMID ... job and write them to a fasta file

```python
lhandle = Entrez.elink(dbfrom="pubmed", db="nucleotide", id="19041262")
lrecord = Entrez.read(lhandle)
ids = []
for el in lrecord[0]["LinkSetDb"][0]["Link"]:
    ids.append(el['Id'])
rrecord = Entrez.efetch(db="nucleotide", id=ids[:4], rettype="fasta", retmode="text")
with open ("py_fasta_pmid.fasta", "w") as ouf:
    ouf.write(rrecord.read()+"\n")
with open("py_fasta_pmid.fasta", "r") as fastaf:
    snippet = [next(fastaf) for x in range(5)]
    print(snippet)
```

## Part 2 - `Bash`

1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

```bash
esearch -email iljapopov17@gmail.com -db pubmed -query "Cyclophilin A AND Open reading frame AND Real-time PCR" | efetch -mode text -format abstract
```

2) Find organism ID by name in the taxonomy database

```bash
esearch -email iljapopov17@gmail.com -db taxonomy -query "Procambarus clarkii" | esummary | grep TaxId
```

3) Query the nucleotide sequence database by gene name and return a table with UIDs

```bash
esearch -email iljapopov17@gmail.com -db nucleotide -query "cyclophilin AND Procambarus clarkii[orgn]" | esummary -mode xml | xtract -pattern DocumentSummary -element Id Caption Slen
```

4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

```bash
esearch -email iljapopov17@gmail.com -db protein -query "cyclophilin AND Procambarus clarkii[orgn]" | efetch -format fasta -mode text >cyclophilin.fa
head cyclophilin.fa
```

5) Download the protein corresponding to the known nucleotide UID

```bash
elink -id 429843488 -db nuccore -target protein | efetch -format fasta -mode text > prot_from_nt.fa
head prot_from_nt.fa
```

6) Download all sequences from the PMID ... job and write them to a fasta file

```bash
elink -db pubmed -target nucleotide -id 19041262 | efetch -format fasta -mode text > py_fasta_pmid.fa
head py_fasta_pmid.fa
```

## Part 3 - `R`

```r
library(reutils)
options(reutils.email = "iljapopov17@gmail.com")
```

1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

```r
ms <- esearch(db = "pubmed", term = "Cyclophilin A AND Open reading frame AND Real-time PCR")
abstr <- efetch(ms, rettype = "abstract")
abstr
write(content(abstr), "abstracts.txt")
```

2) Find organism ID by name in the taxonomy database

```r
esearch(db = "taxonomy", term = "Procambarus clarkii")
```

3) Query the nucleotide sequence database by gene name and return a table with UIDs

```r
crcnp <- esearch(db = "nucleotide", term = "cyclophilin AND Procambarus clarkii[orgn]") 
su <- esummary(crcnp)
cosu <- content(su, "parsed")
as.data.frame(cosu[,c("Id", "Caption", "Slen")])
```

4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

```r
s <- esearch(db = "protein", term = "cyclophilin AND Procambarus clarkii[orgn]") 
f <- efetch(uid = s[1:10], db = "protein", rettype = "fasta", retmode = "text")
write(content(f), "cyclophilin.fa")
fastaf <- readLines("cyclophilin.fa")
head(fastaf)
```

5) Download the protein corresponding to the known nucleotide UID

```r
lnk1 <- elink(uid = "429843488", dbFrom = "nucleotide", dbTo = "protein")
protein <- efetch(lnk1, rettype = "fasta", retmode = "text")
write(content(protein), "prot_from_nt.fa")
read_protein <- readLines("prot_from_nt.fa")
head(read_protein)
```

6) Download all sequences from the PMID ... job and write them to a fasta file

```r
ms2 <- esearch(term = "Cyclophilin A AND Open reading frame AND Real-time PCR", db = "pubmed")
lnk <- elink(ms2[2], dbFrom = "pubmed", dbTo = "nuccore")
f2 <- efetch(lnk, rettype = "fasta", retmode = "text")
write(content(f2), "py_fasta_pmid_R.fa")
read_seq <- readLines("py_fasta_pmid_R.fa")
head(read_seq)
```
