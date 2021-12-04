# Mark up of structural sections for article publishing documentary texts (DDB)

See also: [StructureFilesXML](https://docs.google.com/spreadsheets/d/1HaacsPU44Rm4qXWzguBxXorc9F1S3N9HDxpgp-c9kHU/edit#gid=0), where, in the form of a googlespreadsheet, the information is presented in rows and columns with further detail concerning Xpaths.

In the relevant [XSLT file](https://github.com/hcayless/P3-processing/blob/main/xslt/process-tei.xsl#L12-L14) in [P3-processing](https://github.com/hcayless/P3-processing) the list of these individual variable names can be found.

## For every article
### Title, author, affiliation, email and acknowledgement
- #articleTitle
  - Title of the article

- #author
  - Surname comma Forename(s)
  - Surname comma Forename(s)
  
- #affiliation
  - Institute for the Study of the Ancient World (no standardisation, simply a string)
  
- #email
  - mksmi@gmail.com

- #acknowledgement
  - For acknowledging publication permission, thanking others for their contributions (this deals with the * which is often found as a marker for the first footnote in print publications)

Here is an **example of such mark up** as used to produce one of our test files:

- [Claytor Smith Warga BASP 53](https://digi.ub.uni-heidelberg.de/editionService/viewer/text/p3test/ClaytorSmithWarga_FourPoll_TaxReceiptsTrial_4)
  - for which the stuctural mark up of the word document was: [ClaytorSmithWargaPage1.pdf](https://github.com/jcowey/P3/files/7389818/ClaytorSmithWargaPage1.pdf)


## For each and every separate DDB text edited in the article: DOCUMENTARY texts
### Metadata, papyrological header, introduction, text, translation and commentary
- #editionDDB
- #metadata
  - Create a table for the categories that are to be supplied
    - For a list of the categories of metadata see [here](https://github.com/jcowey/P3/blob/master/guidelines/metadataMask.md)

- #papyrologicalHeader:
  - Title (if there is one)
  - Create a table (usually 2 rows and 3 columns) in the word document for the date, measurements, provenance, inventory number, etc

- #introduction
  - Running text in paragraphs

- #text
  - Leiden+ (of the text)
  
- #translation
  - Leiden+ (of the translation)
  
- #commentary
  - Running text in paragraphs

Here is an **example of such mark up** as used to produce one of our test files:

- [Claytor Smith Warga BASP 53 text 2](https://digi.ub.uni-heidelberg.de/editionService/viewer/text/p3test/ClaytorSmithWarga_FourPoll_TaxReceiptsTrial_4#ch_7)
  - for which the stuctural mark up of the word document was: [ClaytorSmithWargaText2.pdf](https://github.com/jcowey/P3/files/7596453/ClaytorSmithWargaText2.pdf)

## For each and every separate DCLP text edited in the article: LITERARY texts
### Metadata, papyrological header, introduction, text, translation and commentary
- #editionDCLP
- #metadata
  - Create a table for the categories that are to be supplied
    - For a list of the categories of metadata see [here](https://github.com/jcowey/P3/blob/master/guidelines/metadataMask.md)

- #papyrologicalHeader:
  - Title (if there is one)
  - Create a table (usually 2 rows and 3 columns) in the word document for the date, measurements, provenance, inventory number, etc

- #introduction
  - Running text in paragraphs

- #text
  - Leiden+ (of the text)
  
- #translation
  - Leiden+ (of the translation)
  
- #commentary
  - Running text in paragraphs

Here is an **example of such mark up** as used to produce one of our test files:

## For every section header in the article
### Any subheadings in the article, any quoted passages, corrections made to existing texts and bibliography
- #articleHeader
  - To be used whenever there are section headings within the article

- #blockQuote / #endBlockQuote
  - To be used whenever a section of text (Greek or otherwise) is quoted from an external source and should be displayed separately as a quote
    - e.g. https://github.com/jcowey/P3/blob/master/pylon/testFiles/ClaytorSmithWarga/ClaytorSmithWarga_FourPoll_TaxReceiptsTrial_4.xml#L321-L325
      - in this case please remember to indicate the end of the block quote by placing #endBlockQuote at the end of the quoted section.

- #corrections
  - whenever there are corrections to existing texts, in tabular form

- #bibliography
  - if a bibliography is included
