# Creating a new issue (Pylon 2, Pylon 3, ...)

Creating an issue: https://docs.pkp.sfu.ca/learning-ojs/en/production-publication#create-issue

Go to issues

- add data in volume and year
- unclick the box with number and title 
- save

This creates the basis for a future issue

# For making a scheduled article for publication in OJS

For skipping submissions etc: https://docs.pkp.sfu.ca/learning-ojs/3.2/en/tools.html#importexport

Go to

Tools / Import/Export / QuickSubmit Plugin

takes me to the first entry page (page 4 of the PDF)

https://www.ub.uni-heidelberg.de/service/pdf/OJS3-Handreichung.pdf

Fill that in.

# How to add the relevant DOI.

Go to identifiers

- click on "Assign" (the DOI will appear in the box, the system knows this from Issue and file name)
  - pattern is 10.48631/pylon.YEAR.VOLUME.FILENUMBER: 
  - 10.48631/pylon.2022.1.89306 
  - 10.48631/pylon.2022.2.92969
- check that it is correct
- if it is correct click on "Save"

Cf. https://www.ub.uni-heidelberg.de/service/pdf/OJS3-Handreichung.pdf (pages 16 and 17)

# Loading galleys

Before the galleys can be uploaded, the following steps have to be taken.
- Load all the XML files into the relevant file of 
- https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/epidoc
- Make sure that all HTMLs and PDFs are doing what they should do.
  - https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/pdf
- Now transfer all
  - XML files to your desktop
  - all PDFs to your desktop
- Now return to OJS and for each submission upload the relevant file from your desktop. (mindblowingly non automatic, but that is the way it is under OJS 3.2)

# How to do the final stage of publishing

When all galleys are loaded and you are ready to publish the volume, go to 

https://journals.ub.uni-heidelberg.de/index.php/pylon/manageIssues#futureIssues

call up the volume concerned and click on “Publish Issue”

Now go to 
- Tools
- Import/Export
- DataCite Export/Registration Plugin

https://journals.ub.uni-heidelberg.de/index.php/pylon/management/importexport/plugin/DataciteExportPlugin

Leave “Settings” untouched
- If the system requires action, choose “The data on this form has changed. Do you wish to continue without
saving”

Go to 
- “Articles”

Remove tick from 
- “Validate XML before the export and registration.”

Once this is done now

Click on “Register”

