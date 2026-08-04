# To make changes to a file that has already been published in a Pylon volume

Note the number of the publication (the six digits at the end of the DOI)

e.g. https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/116432

https://doi.org/10.48631/pylon.2026.9.116432

In this case the six digit number is: **116432**

First of all prepare the the files that you will have to upload to the galleys in OJS.

You will need to change and download the XML file. You will need to download the PDFs.

Sign in to gitlab.

## Accessing, changing and downloading the XML file 

Navigate in the gitlab folders and files to get to that file

https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon

Go to the epidoc folder.

https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/epidoc?ref_type=heads

Locate and open the relevant folder (number of the relevant Pylon volume)

There you will find the .xml file which you need

https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/blob/main/epidoc/9/116432.xml?ref_type=heads

It is in this text that you must make the change or changes and save it / them. 

The system is set up in such a way that when you save in the `epidoc folder` then the corresponding file in the `converted folder`: https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/converted?ref_type=heads reflects the update.

You must remember that you take the xml file from the `converted folder` NOT from the epidoc folder.

Now you have to navigate to the file in this converted folder. Click on the file. In the upper right hand corner you will see a black button with the word edit in it. Below that is a white button with the word History in it. Below that you will see two buttons: to the left a white button with the word Blame in it. To the right choose the download icon. This will download the updated version of the file you need to put into the the OJS interface to update the live online version of the article.

That is the file you will upload to the HTML galley and the TEI download galley. Save it on your desktop (or remember that it is in your download folder)

Now you have to locate the two PDF files which you will upload the the PDF galleys.

https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/pipelines 

- to view the PDFs one has to go to https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/pipelines
  - choose the "Passed" section. On the far right there is a download button. Click on the download button, then click on transformation:archive
  - that will download to your computer (in Downloads on a Mac)
  - open the zip file and then you can view the PDFs
  - it will make sense to file these clearly for uploading to the galleys


