# Mark up of structural sections for article publishing documentary texts (DDB)

See also: [StructureFilesXML](https://docs.google.com/spreadsheets/d/1HaacsPU44Rm4qXWzguBxXorc9F1S3N9HDxpgp-c9kHU/edit#gid=0)

## For every article
- #articleTitle
  - Title of the article

- #author
  - surname comma forename(s)
  - surname comma forename(s)
  
- #affiliation
  - Institute for the Study of the Ancient World (no standardisation, simply a string)
  
- #email

- #acknowledgement
  - For acknowledging publication permission, thanking others for their contributions (this deals with the * which is often found as a marker for the first footnote in print publications)

Here is an example of such mark up as used to produce one of our test files:

- [Claytor Smith Warga BASP 53](https://digi.ub.uni-heidelberg.de/editionService/viewer/text/p3test/ClaytorSmithWarga_FourPoll_TaxReceiptsTrial_4)
  - for which the stuctural mark up of the word document was: [ClaytorSmithWargaPage1.pdf](https://github.com/jcowey/P3/files/7389818/ClaytorSmithWargaPage1.pdf)


## for each and every separate DDB text edited in the article
- #editionDDB
- #metadata
  - In table form
    - For a list of the categories of metadata see [here](https://github.com/jcowey/P3/blob/master/guidelines/metadataMask.md)

- #papyrologicalHeader:
  - Title (if there is one)
  - In table form the date, measurements, provenance, inventory number, etc

- #introduction
  - Running text in paragraphs

- #text
  - Leiden+ (of the text)
  
- #translation
  - Leiden+ (of the translation)
  
- #commentary
  - Running text in paragraphs

## for every section header in the article
- #articleHeader
  - To be used whenever there are section headings within the article

- #quote
  - To be used whenever a section of text (Greek or otherwise) is quoted from an external source and should be displayed separately as a quote
    - e.g. https://github.com/jcowey/P3/blob/master/pylon/testFiles/ClaytorSmithWarga/ClaytorSmithWarga_FourPoll_TaxReceiptsTrial_4.xml#L321-L325

- #corrections
  - whenever there are corrections to existing texts, in tabular form

- #bibliography
  - if a bibliography is included
