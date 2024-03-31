# Working with NCBI

- `phylo-2.Rmd` & `phylo-2.ipynb` - contains this whole pipeline done

## Part 1 - `Python`

**_Input_**

```python
from Bio import Entrez
Entrez.email = 'iljapopov17@gmail.com'
```

### 1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

**_Input_**

```python
handle = Entrez.esearch(db = "pubmed", term = "Cyclophilin A AND Open reading frame AND Real-time PCR")
record = Entrez.read(handle)
print(record)
mshandle = Entrez.efetch(db="pubmed", id=record["IdList"][0:2], rettype="abstract", retmode="text")
print(mshandle.read())
```

**_Output_**

```
{'Count': '3', 'RetMax': '3', 'RetStart': '0', 'IdList': ['29097323', '19041262', '18819019'], 'TranslationSet': [{'From': 'Cyclophilin A', 'To': '"cyclophilin a"[MeSH Terms] OR "cyclophilin a"[All Fields]'}, {'From': 'Open reading frame', 'To': '"open reading frames"[MeSH Terms] OR ("open"[All Fields] AND "reading"[All Fields] AND "frames"[All Fields]) OR "open reading frames"[All Fields] OR ("open"[All Fields] AND "reading"[All Fields] AND "frame"[All Fields]) OR "open reading frame"[All Fields]'}, {'From': 'Real-time PCR', 'To': '"real-time polymerase chain reaction"[MeSH Terms] OR ("real-time"[All Fields] AND "polymerase"[All Fields] AND "chain"[All Fields] AND "reaction"[All Fields]) OR "real-time polymerase chain reaction"[All Fields] OR ("real"[All Fields] AND "time"[All Fields] AND "pcr"[All Fields]) OR "real time pcr"[All Fields]'}], 'QueryTranslation': '("cyclophilin a"[MeSH Terms] OR "cyclophilin a"[All Fields]) AND ("open reading frames"[MeSH Terms] OR ("open"[All Fields] AND "reading"[All Fields] AND "frames"[All Fields]) OR "open reading frames"[All Fields] OR ("open"[All Fields] AND "reading"[All Fields] AND "frame"[All Fields]) OR "open reading frame"[All Fields]) AND ("real time polymerase chain reaction"[MeSH Terms] OR ("real time"[All Fields] AND "polymerase"[All Fields] AND "chain"[All Fields] AND "reaction"[All Fields]) OR "real time polymerase chain reaction"[All Fields] OR ("real"[All Fields] AND "time"[All Fields] AND "pcr"[All Fields]) OR "real time pcr"[All Fields])'}
1. Fish Shellfish Immunol. 2018 Jan;72:383-388. doi: 10.1016/j.fsi.2017.10.053. 
Epub 2017 Oct 31.

Molecular identification and expression analysis of a novel cyclophilin a gene 
in the red swamp crayfish, Procambarus clarkii.

Zhu J(1), Lin F(2), Li F(2), Wang Y(3).

Author information:
(1)College of Animal Sciences, Zhejiang University, Hangzhou, 310058, China; 
School of Life Sciences, RanHuzhou University, Huzhou, 313000, China.
(2)Zhejiang Institute of Freshwater Fisheries, Huzhou, 313001, China.
(3)College of Animal Sciences, Zhejiang University, Hangzhou, 310058, China. 
Electronic address: ywang@zju.edu.cn.

Cyclophilin A (Cyp A) is the main intracellular receptor of cyclosporin A (CsA) 
belonging to the immunophilin family, which is known as an effective 
immunosuppressive drug. This study aimed to gain insights into the structure and 
biological function of cyclophilin A in the red swamp crayfish, Procambarus 
clarkii (PcCypA). We cloned PcCypA by homology cloning and anchored polymerase 
chain reaction (PCR), and assessed its mRNA and protein expression levels in 
different tissues using quantitative real-time PCR and western blot analysis, 
respectively. The full-length DNA contained a 5' untranslated region (UTR) 
comprising 108 base pairs (bp), an open reading frame of 495 bp encoding a 
polypeptide of 164 amino acids with an estimated molecular mass of 17.3 kDa, and 
a 3' UTR of 281 bp including a significant poly(A) plus tail sequence. The 
predicted amino acid sequence of PcCypA shared high identity with CypA in other 
organisms. PcCypA transcripts were detected in the hepatopancreas, gill, heart, 
muscle, testis, and ovary of crayfish, with the highest expression levels in the 
heart. Western blot analysis found one 17-kDa band in all of the tissues 
examined, except for the ovary. Molecular identification and expression analysis 
of PcCypA will facilitate further studies of the immune defense mechanisms in 
red swamp crayfish, and provide new insights into freshwater invertebrate 
immunology.

Copyright © 2017 Elsevier Ltd. All rights reserved.

DOI: 10.1016/j.fsi.2017.10.053
PMID: 29097323 [Indexed for MEDLINE]


2. Fish Shellfish Immunol. 2009 Jan;26(1):115-21. doi: 10.1016/j.fsi.2008.03.022.
 Epub 2008 Apr 7.

Molecular cloning and mRNA expression of cyclophilin A gene in black tiger 
shrimp (Penaeus monodon).

Qiu L(1), Jiang S, Huang J, Wang W, Zhu C, Su T.

Author information:
(1)The South China Sea Fisheries Research Institute, Chinese Academy of Fishery 
Sciences, Guangzhou, PR China.

The techniques of homology cloning and anchored PCR were used to clone the 
cyclophilin A (CypA) gene from black tiger shrimp (Penaeus monodon). The 
full-length cDNA of black tiger shrimp CypA (btsCypA) contained a 5' 
untranslated region (UTR) of 81 bp, an ORF (open reading frame) of 495 bp 
encoding a polypeptide of 164 amino acids with an estimated molecular mass of 
17.68 kDa and a 3' UTR of 308 bp. The predicted amino acid sequence of btsCypA 
shared high identity with CypA in other organisms. A quantitative reverse 
transcriptase Real-Time PCR (qRT-PCR) assay was developed to assess the mRNA 
expression of btsCypA in different tissues and the temporal expression of 
btsCypA in the hepatopancreas challenged by lipopolyssacharide (LPS). 
Higher-level mRNA expression of btsCypA was detected in the tissues of 
hepatopancreas and blood. The expression of btsCypA in the hepatopancreas was up 
regulated after stimulated by LPS. The results indicated that btsCypA was a 
constitutive and inducible expressed protein and could be induced by LPS.

DOI: 10.1016/j.fsi.2008.03.022
PMID: 19041262 [Indexed for MEDLINE]
```

### 2) Find organism ID by name in the taxonomy database

**_Input_**

```python
handle = Entrez.esearch(db = "taxonomy", term = "Procambarus clarkii") record = Entrez.read(handle)
print(record)
print(record['IdList'])
```

**_Output_**

```
{'Count': '1', 'RetMax': '1', 'RetStart': '0', 'IdList': ['6728'], 'TranslationSet': [], 'TranslationStack': [{'Term': 'Procambarus clarkii[All Names]', 'Field': 'All Names', 'Count': '1', 'Explode': 'N'}, 'GROUP'], 'QueryTranslation': 'Procambarus clarkii[All Names]'}
['6728']
```

### 3) Query the nucleotide sequence database by gene name and return a table with UIDs

**_Input_**

```python
handle = Entrez.esearch(db="nucleotide", term="cyclophilin AND Procambarus clarkii[orgn]")
record = Entrez.read(handle)
for rec in record["IdList"]:
        temphandle = Entrez.read(Entrez.esummary(db="nucleotide", id=rec, retmode="text"))
        print(temphandle[0]['Id']+"\t"+temphandle[0]['Caption']+"\t"+str(int(temphandle[0]['Length'])))#+"\n")
```

**_Output_**

```
1940114972	MT601694	636
429843488	JX878886	495
```

### 4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

**_Input_**

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

**_Output_**

```
['>QPM92673.1 cyclophilin [Procambarus clarkii]\n', 'MKALVAVVALLVIFSVFNRADGQAGESKGPKVTHKVFFDITIGGVPKGTVVIGLFGSTVPRTAQNFFELA\n', 'QKPVGEGYKGSVFHRVIKDFMIQGGDFTRGDGTGGRSIYGERFADENFKLKHFGAGWLSMANAGKDTNGS\n', 'QFFITTNKTTWLDGKHVVFGKVLAGMPIIREIEASATDGRDRPVAEVKIVDSRGEALSQPFESVAKEDAT\n', 'D\n']
```

### 5) Download the protein corresponding to the known nucleotide UID

**_Input_**

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

**_Output_**

```
['>AGA16578.1 cyclophilin A [Procambarus clarkii]\n', 'MGNPQVFFDITANGKPLGRIVMELRADVVPKTAENFRALCTGEKGFGYKGSTFHRVIPNFMCQGGDFTAG\n', 'NGTGGKSIYGSKFADENFQLPHDGPGILSMANAGPNTNGSQFFLCTVRTNWLDGKHVVLGKVTEGMDVVR\n', 'QIEGYGKPSGETSAKIVVANCGQL\n', '\n']
```

### 6) Download all sequences from the PMID ... job and write them to a fasta file

**_Input_**

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

**_Output_**

```
['>EU164775.1 Penaeus monodon cyclophilin A mRNA, complete cds\n', 'CTCGTCCTCGGTTCCCGGCGATCCTCTGGAGATTGTTGCCGTAGATGGACTTGCGAGCAGACCTACACCA\n', 'ACTTAGCCACCATGGGCAACCCCAAAGTCTTTTTCGACATTACCGCTGACAACCAGCCCGTTGGCAGGAT\n', 'CGTCATGGAGCTCCGCGCCGACGTGGTCCCCAAGACCGCCGAGAACTTCCGGTCGCTGTGCACGGGCGAG\n', 'AAGGGCTTCGGCTACAAGGGTTCCTGCTTCCACCGCGTGATCCCCAACTTCATGTGTCAGGGAGGCGACT\n']
```

## Part 2 - `Bash`

### 1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

**_Input_**

```bash
esearch -email iljapopov17@gmail.com -db pubmed -query "Cyclophilin A AND Open reading frame AND Real-time PCR" | efetch -mode text -format abstract
```

**_Output_**

```
1. Fish Shellfish Immunol. 2018 Jan;72:383-388. doi: 10.1016/j.fsi.2017.10.053. 
Epub 2017 Oct 31.

Molecular identification and expression analysis of a novel cyclophilin a gene 
in the red swamp crayfish, Procambarus clarkii.

Zhu J(1), Lin F(2), Li F(2), Wang Y(3).

Author information:
(1)College of Animal Sciences, Zhejiang University, Hangzhou, 310058, China; 
School of Life Sciences, RanHuzhou University, Huzhou, 313000, China.
(2)Zhejiang Institute of Freshwater Fisheries, Huzhou, 313001, China.
(3)College of Animal Sciences, Zhejiang University, Hangzhou, 310058, China. 
Electronic address: ywang@zju.edu.cn.

Cyclophilin A (Cyp A) is the main intracellular receptor of cyclosporin A (CsA) 
belonging to the immunophilin family, which is known as an effective 
immunosuppressive drug. This study aimed to gain insights into the structure and 
biological function of cyclophilin A in the red swamp crayfish, Procambarus 
clarkii (PcCypA). We cloned PcCypA by homology cloning and anchored polymerase 
chain reaction (PCR), and assessed its mRNA and protein expression levels in 
different tissues using quantitative real-time PCR and western blot analysis, 
respectively. The full-length DNA contained a 5' untranslated region (UTR) 
comprising 108 base pairs (bp), an open reading frame of 495 bp encoding a 
polypeptide of 164 amino acids with an estimated molecular mass of 17.3 kDa, and 
a 3' UTR of 281 bp including a significant poly(A) plus tail sequence. The 
predicted amino acid sequence of PcCypA shared high identity with CypA in other 
organisms. PcCypA transcripts were detected in the hepatopancreas, gill, heart, 
muscle, testis, and ovary of crayfish, with the highest expression levels in the 
heart. Western blot analysis found one 17-kDa band in all of the tissues 
examined, except for the ovary. Molecular identification and expression analysis 
of PcCypA will facilitate further studies of the immune defense mechanisms in 
red swamp crayfish, and provide new insights into freshwater invertebrate 
immunology.

Copyright © 2017 Elsevier Ltd. All rights reserved.

DOI: 10.1016/j.fsi.2017.10.053
PMID: 29097323 [Indexed for MEDLINE]


2. Fish Shellfish Immunol. 2009 Jan;26(1):115-21. doi: 10.1016/j.fsi.2008.03.022.
 Epub 2008 Apr 7.

Molecular cloning and mRNA expression of cyclophilin A gene in black tiger 
shrimp (Penaeus monodon).

Qiu L(1), Jiang S, Huang J, Wang W, Zhu C, Su T.

Author information:
(1)The South China Sea Fisheries Research Institute, Chinese Academy of Fishery 
Sciences, Guangzhou, PR China.

The techniques of homology cloning and anchored PCR were used to clone the 
cyclophilin A (CypA) gene from black tiger shrimp (Penaeus monodon). The 
full-length cDNA of black tiger shrimp CypA (btsCypA) contained a 5' 
untranslated region (UTR) of 81 bp, an ORF (open reading frame) of 495 bp 
encoding a polypeptide of 164 amino acids with an estimated molecular mass of 
17.68 kDa and a 3' UTR of 308 bp. The predicted amino acid sequence of btsCypA 
shared high identity with CypA in other organisms. A quantitative reverse 
transcriptase Real-Time PCR (qRT-PCR) assay was developed to assess the mRNA 
expression of btsCypA in different tissues and the temporal expression of 
btsCypA in the hepatopancreas challenged by lipopolyssacharide (LPS). 
Higher-level mRNA expression of btsCypA was detected in the tissues of 
hepatopancreas and blood. The expression of btsCypA in the hepatopancreas was up 
regulated after stimulated by LPS. The results indicated that btsCypA was a 
constitutive and inducible expressed protein and could be induced by LPS.

DOI: 10.1016/j.fsi.2008.03.022
PMID: 19041262 [Indexed for MEDLINE]


3. Mol Biol Rep. 2009 Jul;36(6):1637-45. doi: 10.1007/s11033-008-9363-8. Epub
2008  Sep 26.

A cyclophilin A inducible expressed in gonad of zhikong scallop Chlamys farreri.

Song X(1), Wang L, Song L, Zhao J, Zhang H, Zheng P, Qiu L, Liu X, Wu L.

Author information:
(1)College of Animal Science and Technology, Northwest A&F University, Yangling, 
Shaanxi, 712100, China.

Cyclophilin A (CypA), a receptor for the immunosuppressive agent cyclosporin A 
(CsA), is a cis-trans peptidyl-prolyl isomerase (PPIase) which accelerates the 
cis-trans isomerization of prolyl-peptide bonds, interacts with a variety of 
proteins and therefore regulates their activities. One CypA (designated CfCypA) 
cDNA was cloned from Chlamys farreri by expressed sequence tag (EST) and rapid 
amplification of cDNA ends (RACE) techniques. The full-length cDNA of CfCypA 
consisted of 1,248 nucleotides with a canonical polyadenylation signal sequence 
AATAAA, a poly (A) tail, and an open reading frame (ORF) of 495 nucleotides 
encoding a polypeptide of 164 amino acids. The deduced amino acid sequence 
shared high similarity with CypA from the other species, indicating that CfCypA 
should be a new member of the CypA family. Quantitative real-time (RT) PCR was 
employed to assess the mRNA expression of CfCypA in various tissues and its 
temporal expression in haemocytes and gonad of scallops challenged with Vibrio 
anguillarum. The mRNA transcripts of CfCypA could be detected in all the 
examined tissues with highest expression level in gonad. After bacterial 
challenge, the expression level of CfCypA was almost unchanged in haemocytes, 
but up-regulated in gonad and increased to the peak (22.59-fold; P < 0.05) at 4 
h post-injection, and then dropped to the original level at 8 h post-injection. 
These results indicated that CfCypA was constitutive expressed in haemocytes, 
but could be induced in gonad, and perhaps played a critical role in response to 
the bacterial challenge in gonad.

DOI: 10.1007/s11033-008-9363-8
PMID: 18819019 [Indexed for MEDLINE]
```

### 2) Find organism ID by name in the taxonomy database

**_Input_**

```bash
esearch -email iljapopov17@gmail.com -db taxonomy -query "Procambarus clarkii" | esummary | grep TaxId
```

**_Output_**

```
    <TaxId>6728</TaxId>
    <AkaTaxId>0</AkaTaxId>
```

### 3) Query the nucleotide sequence database by gene name and return a table with UIDs

**_Input_**

```bash
esearch -email iljapopov17@gmail.com -db nucleotide -query "cyclophilin AND Procambarus clarkii[orgn]" | esummary -mode xml | xtract -pattern DocumentSummary -element Id Caption Slen
```

**_Output_**

```
1940114972	MT601694	636
429843488	JX878886	495
```

### 4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

**_Input_**

```bash
esearch -email iljapopov17@gmail.com -db protein -query "cyclophilin AND Procambarus clarkii[orgn]" | efetch -format fasta -mode text >cyclophilin.fa
head cyclophilin.fa
```

**_Output_**

```
>QPM92673.1 cyclophilin [Procambarus clarkii]
MKALVAVVALLVIFSVFNRADGQAGESKGPKVTHKVFFDITIGGVPKGTVVIGLFGSTVPRTAQNFFELA
QKPVGEGYKGSVFHRVIKDFMIQGGDFTRGDGTGGRSIYGERFADENFKLKHFGAGWLSMANAGKDTNGS
QFFITTNKTTWLDGKHVVFGKVLAGMPIIREIEASATDGRDRPVAEVKIVDSRGEALSQPFESVAKEDAT
D
>AGA16578.1 cyclophilin A [Procambarus clarkii]
MGNPQVFFDITANGKPLGRIVMELRADVVPKTAENFRALCTGEKGFGYKGSTFHRVIPNFMCQGGDFTAG
NGTGGKSIYGSKFADENFQLPHDGPGILSMANAGPNTNGSQFFLCTVRTNWLDGKHVVLGKVTEGMDVVR
QIEGYGKPSGETSAKIVVANCGQL
```

### 5) Download the protein corresponding to the known nucleotide UID

**_Input_**

```bash
elink -id 429843488 -db nuccore -target protein | efetch -format fasta -mode text > prot_from_nt.fa
head prot_from_nt.fa
```

**_Output_**

```
>AGA16578.1 cyclophilin A [Procambarus clarkii]
MGNPQVFFDITANGKPLGRIVMELRADVVPKTAENFRALCTGEKGFGYKGSTFHRVIPNFMCQGGDFTAG
NGTGGKSIYGSKFADENFQLPHDGPGILSMANAGPNTNGSQFFLCTVRTNWLDGKHVVLGKVTEGMDVVR
QIEGYGKPSGETSAKIVVANCGQL
```

### 6) Download all sequences from the PMID ... job and write them to a fasta file

**_Input_**

```bash
elink -db pubmed -target nucleotide -id 19041262 | efetch -format fasta -mode text > py_fasta_pmid.fa
head py_fasta_pmid.fa
```

**_Output_**

```
>EU164775.1 Penaeus monodon cyclophilin A mRNA, complete cds
CTCGTCCTCGGTTCCCGGCGATCCTCTGGAGATTGTTGCCGTAGATGGACTTGCGAGCAGACCTACACCA
ACTTAGCCACCATGGGCAACCCCAAAGTCTTTTTCGACATTACCGCTGACAACCAGCCCGTTGGCAGGAT
CGTCATGGAGCTCCGCGCCGACGTGGTCCCCAAGACCGCCGAGAACTTCCGGTCGCTGTGCACGGGCGAG
AAGGGCTTCGGCTACAAGGGTTCCTGCTTCCACCGCGTGATCCCCAACTTCATGTGTCAGGGAGGCGACT
TCACCGCCGGCAACGGCACGGGCGGCAAGTCCATCTACGGCAACAAATTCGAGGACGAGAACTTCGCACT
GAAGCACACCGGCCCCGGCACCCTGTCCATGGCCAACGCCGGCCCCAACACCAACGGGTCGCAATTCTTC
ATCTGCACCGTCAAAACCCCCTGGCTGGACAACAAGCACGTGGTTTTCGGCTCCGTGGTGGAGGGCATGG
ACATCGTGCGCCAGGTCGAGGGTTTCGGCACCCCCAACGGCTCTTGCAAGCGGAAAGTGATGATCGCCAA
CTGCGGCCAGCTGTAAAGTTTCAGAACATTCCCCCTTAGCCGCCCACCCCTTTTTTTTTTGATGTAATTG
```

## Part 3 - `R`

**_Input_**

```r
library(reutils)
options(reutils.email = "iljapopov17@gmail.com")
```

### 1) Find articles in PubMed for a query of interest to you and return abstracts of those articles in plain text format

**_Input_**

```r
ms <- esearch(db = "pubmed", term = "Cyclophilin A AND Open reading frame AND Real-time PCR")
abstr <- efetch(ms, rettype = "abstract")
abstr
write(content(abstr), "abstracts.txt")
```

**_Output_**

```
## Object of class 'efetch'
## 1. Fish Shellfish Immunol. 2018 Jan;72:383-388. doi: 10.1016/j.fsi.2017.10.053.
## Epub 2017 Oct 31.
##
## Molecular identification and expression analysis of a novel cyclophilin a gene
## in the red swamp crayfish, Procambarus clarkii.
##
## Zhu J(1), Lin F(2), Li F(2), Wang Y(3).
##
## Author information:
## (1)College of Animal Sciences, Zhejiang University, Hangzhou, 310058, China;
## School of Life Sciences, RanHuzhou University, Huzhou, 313000, China.
## (2)Zhejiang Institute of Freshwater Fisheries, Huzhou, 313001, China.
## ...
## EFetch query using the 'pubmed' database.
## Query url: 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?=efe...'
## Retrieval type: 'abstract', retrieval mode: 'text'
```

### 2) Find organism ID by name in the taxonomy database

**_Input_**

```r
esearch(db = "taxonomy", term = "Procambarus clarkii")
```

**_Output_**

```
## Object of class 'esearch'
## List of UIDs from the 'taxonomy' database.
## [1] "6728"
```

### 3) Query the nucleotide sequence database by gene name and return a table with UIDs

**_Input_**

```r
crcnp <- esearch(db = "nucleotide", term = "cyclophilin AND Procambarus clarkii[orgn]") 
su <- esummary(crcnp)
cosu <- content(su, "parsed")
as.data.frame(cosu[,c("Id", "Caption", "Slen")])
```

**_Output_**

```
## Id Caption Slen
## 1 1940114972 MT601694 636
## 2 429843488 JX878886 495
```

### 4) Give the nucleotide or protein sequence database a text query and then return the sequences in fasta format, which we write to a file

**_Input_**

```r
s <- esearch(db = "protein", term = "cyclophilin AND Procambarus clarkii[orgn]") 
f <- efetch(uid = s[1:10], db = "protein", rettype = "fasta", retmode = "text")
write(content(f), "cyclophilin.fa")
fastaf <- readLines("cyclophilin.fa")
head(fastaf)
```

**_Output_**

```
## [1] ">QPM92673.1 cyclophilin [Procambarus clarkii]"
## [2] "MKALVAVVALLVIFSVFNRADGQAGESKGPKVTHKVFFDITIGGVPKGTVVIGLFGSTVPRTAQNFFELA"
## [3] "QKPVGEGYKGSVFHRVIKDFMIQGGDFTRGDGTGGRSIYGERFADENFKLKHFGAGWLSMANAGKDTNGS"
## [4] "QFFITTNKTTWLDGKHVVFGKVLAGMPIIREIEASATDGRDRPVAEVKIVDSRGEALSQPFESVAKEDAT"
## [5] "D"
## [6] ""
```

### 5) Download the protein corresponding to the known nucleotide UID

**_Input_**

```r
lnk1 <- elink(uid = "429843488", dbFrom = "nucleotide", dbTo = "protein")
protein <- efetch(lnk1, rettype = "fasta", retmode = "text")
write(content(protein), "prot_from_nt.fa")
read_protein <- readLines("prot_from_nt.fa")
head(read_protein)
```

**_Output_**

```
## [1] ">AGA16578.1 cyclophilin A [Procambarus clarkii]"
## [2] "MGNPQVFFDITANGKPLGRIVMELRADVVPKTAENFRALCTGEKGFGYKGSTFHRVIPNFMCQGGDFTAG"
## [3] "NGTGGKSIYGSKFADENFQLPHDGPGILSMANAGPNTNGSQFFLCTVRTNWLDGKHVVLGKVTEGMDVVR"
## [4] "QIEGYGKPSGETSAKIVVANCGQL"
## [5] ""
## [6] ""
```

### 6) Download all sequences from the PMID ... job and write them to a fasta file

**_Input_**

```r
ms2 <- esearch(term = "Cyclophilin A AND Open reading frame AND Real-time PCR", db = "pubmed")
lnk <- elink(ms2[2], dbFrom = "pubmed", dbTo = "nuccore")
f2 <- efetch(lnk, rettype = "fasta", retmode = "text")
write(content(f2), "py_fasta_pmid_R.fa")
read_seq <- readLines("py_fasta_pmid_R.fa")
head(read_seq)
```

**_Output_**

```
## [1] ">EU164775.1 Penaeus monodon cyclophilin A mRNA, complete cds"
## [2] "CTCGTCCTCGGTTCCCGGCGATCCTCTGGAGATTGTTGCCGTAGATGGACTTGCGAGCAGACCTACACCA"
## [3] "ACTTAGCCACCATGGGCAACCCCAAAGTCTTTTTCGACATTACCGCTGACAACCAGCCCGTTGGCAGGAT"
## [4] "CGTCATGGAGCTCCGCGCCGACGTGGTCCCCAAGACCGCCGAGAACTTCCGGTCGCTGTGCACGGGCGAG"
## [5] "AAGGGCTTCGGCTACAAGGGTTCCTGCTTCCACCGCGTGATCCCCAACTTCATGTGTCAGGGAGGCGACT"
## [6] "TCACCGCCGGCAACGGCACGGGCGGCAAGTCCATCTACGGCAACAAATTCGAGGACGAGAACTTCGCACT"
```
