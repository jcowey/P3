# Figure

Templates for figures

- normal

```XML
               <figure>
                  <ptr ana="hc:HeidICONImageResourceReference" target="https://heidicon.ub.uni-heidelberg.de/detail/24060368"/>
                  <head>Fig. 1: P. Heid. inv. G 263.</head>
               </figure>
```

## Minor notes

- If a figure has to be embedded in the commentary section, then `<figure>` is added at the same level as `<note>` and at the end of the note it in which it is required.

- e.g. https://gitlab.ub.uni-heidelberg.de/verlag/PapyrologicalPublicationPlatform/-/blob/master/epidoc/Pylon_9_Ast/ast_notes.xml?ref_type=heads#L200-207
```XML
 <note target="#ed1ln12">
    <ref>12</ref>
    <p xml:id="p27"> The chi in τύχη is obscured by abrasion. This tracing illustrates how the letter appears to have been drawn. FIGURE </p>
 </note>
 <figure>
    <ptr ana="hc:HeidICONImageResourceReference" target="https://heidicon.ub.uni-heidelberg.de/detail/24221860"/>
    <head>Fig. 4: </head>
 </figure>

```
