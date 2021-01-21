While working on DDB Editorial Board submissions the following file appeared:
https://papyri.info/editor/publications/95932/ddb_identifiers/219829/editxml

In it there were corrections made to the text:

`<app type="editorial"><lem resp="W.G. Claytor, TM Arch 663 (Version 1, 2021) 1"><supplied reason="lost">Σαβείνου</supplied></lem><rdg><gap reason="lost" quantity="6" unit="character"/></rdg></app>` 

for

https://github.com/papyri/idp.data/blob/master/DDB_EpiDoc_XML/chr.mitt/chr.mitt.116.xml#L78

and

`<app type="editorial"><lem resp="W.G. Claytor, TM Arch 663 (Version 1, 2021) 1"><supplied reason="lost">Σαβεῖνο</supplied>ς</lem><rdg><gap reason="lost" quantity="6" unit="character"/>ς</rdg></app>` 

for

https://github.com/papyri/idp.data/blob/master/DDB_EpiDoc_XML/chr.mitt/chr.mitt.116.xml#L124

The element
`<lem resp="W.G. Claytor, TM Arch 663 (Version 1, 2021) 1">` 
is not so good on two levels
 * `TM Arch 663 (Version 1, 2021) 1` is relatively arcane
 * there is no link to https://www.trismegistos.org/arch/archives/pdf/663.pdf
 
Seeing the name of the person correcting is however good.

On a different but P3 related topic.
One has to skim read the whole PDF to get the information. The relevant information
is in paragraph 2 of the Description: This is not hard because the whole PDF is 
small, but imagine the PDF is much longer.
To be able to point at the paragraph / footnote of the PDF for where one finds 
the information would be optimal.
This is why it should be possible to guide to a paragraph with a clear URL reference.
