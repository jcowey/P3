### First results

For anyone who wants to skip my prose and just view the files and get to grips with them that way, then go [here.](https://github.com/jcowey/P3/tree/master/pdfs/PDF_improvement_experimentation)

A few comments on the experiment files so far.

1. O.Berenike 4 in HTML: [Ast, Bagnall, Vanderheyden](https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/89358/83988)
   - Here is the PDF in its [original version](https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/89358/84248)
     - Each image precedes the transcription directly
   - and once the new floating transformation has been implemented, a PDF in its ['floated' version](https://github.com/jcowey/P3/blob/master/pdfs/PDF_improvement_experimentation/p3test_ast_bagnall_berenike_4_text_float_after.pdf). Comment by Leo Maylein on this version: "Hier müssen wir dann aber noch dafür sorgen, dass nicht einzelne Zeilen einer Edition umgebrochen werden (bullet point 4 below "After §22 the text of O.Berenike 4 514 is interrupted by the image under which line 3 of the text follows.") oder der Header eines Papyrus (bullet point 5 below "After §93 "527. Latin ostrakon" follows ...") auseinander gerissen wird."
     - Now the images are placed whenever the system finds a place to put them.
     - In §8 the image is embedded in the middle of the paragraph, which is the introduction to O.Berenike 4 512.
     - In §12 (the second paragraph of the introduction to O.Berenike 4 513) the image is embedded/floated.
     - After §22 the text of O.Berenike 4 514 is interrupted by the image under which line 3 of the text follows.
     - in §60 in the introduction to O.Berenike 4 521 Fig. 10: 520 is embedded. In other words the image of O.Berenike 4 520 **!!!** is embedded in the introduction to O.Berenike 4 521. Fig 11: 521 is included after the translation of O.Berenike 4 521 and just before O.Berenike 4 522.
     - After §93 "527. Latin ostrakon" follows. Here the first two lines of the "papyrological header" are interrupted by the image of the ostracon. The last line of the "papyrological header" is place below the image just before §94.
   
2. Scholia minora to Iliad 1.1-12 in HTML [Lougovaya](https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/98180/93353)
   - Here is the PDF in its [original version](https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/98180/93354)
   - and once the new floating transformation has been implemented, a PDF in its ['floated' version](https://github.com/jcowey/P3/blob/master/pdfs/PDF_improvement_experimentation/p3test_lougovaya_scholia_text_float_after.pdf). Comment by Leo Maylein on this version: "Übrigens können jetzt theoretisch auch Tabellen gefloatet werden, wenn sie entsprechend in TEI markiert hc:DetachedTable. Und bei Tabellen sollte nun auch sichergestellt sein, dass die ersten drei und die letzten drei Zeilen zusammenhängend auf einer Seite sind."
     - The two enhanced images which were placed after §2 the edition are now embedded in §1.
     - The images which preceded the edition have now been embedded slightly earlier in the flow of the text in §5.



