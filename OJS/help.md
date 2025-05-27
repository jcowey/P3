 # Creating a new issue (Pylon 8, Pylon 9, ...)

Creating an issue: https://docs.pkp.sfu.ca/learning-ojs/en/production-publication#create-issue

Go to issues

- choose Future Issues
- Create Issue
- add data in volume and year (number is not used - it is excluded with the step below)
- unclick the box with number and title 
- save

This creates the basis for a future issue

# For making a scheduled article for publication in OJS

For skipping submissions etc: https://docs.pkp.sfu.ca/learning-ojs/3.2/en/tools.html#importexport

Go to

Tools / Import/Export / QuickSubmit Plugin

takes me to the first entry page (page 4 of the PDF)

https://www.ub.uni-heidelberg.de/service/pdf/OJS3-Handreichung.pdf

Fill that in:
- Submission Language;
- Section (Articles / Notes and Corrections);
- Title;
- Type (Text);
- Languages (`en`  remember to hit the return key to secure the entry);
- Keywords;
- List of contributors

Go to submission.

Publication.

Schedule for publication.

Issue: choose relevant value (= volume number)

Save

Schedule for publication.

The galleys can be prepared in advance. Click on Add galley.
- Enter HTML first (that way it appears first in the preview)
- Choose the relevant language (should correspond to the language of the article itself)
- Save
- Choose Article Text
- Click on cancel if not uploading immediately
- Now do the same for PDF
  - HTML
  - PDF images embedded
  - PDF images appended
  - XML (EpiDoc) download
  
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
  - When making the commit it is helpful to type "Added \d+ (OJS number of the file you are uploading) as new file. That will help to identify it in the list at https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/pipelines
- Make sure that all HTMLs and PDFs are doing what they should do.
  - https://digi.ub.uni-heidelberg.de/editionService/viewer/pylon/89306
  - to view the PDFs one has to go to https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/pipelines
    - choose the "Passed" section. On the far right there is a download button. Click on the download button, then click on `transformation:archive`
    - that will download to your computer (in Downloads on a Mac)
    - open the zip file and then you can view the PDFs
    - it will make sense to file these clearly for uploading to the galleys
- Now check that all the XML files are in (this should happen automatically within the system)
- https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/converted
- Now transfer all
  - XML files to your desktop (go to the far right and choose "code" then choose "Download this directory" "zip")
    - from the relevant folder in https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/tree/main/converted
  - all PDFs will be on your desktop through the pipeline manoeuver described above
- Now return to OJS and for each and every submission upload the relevant files (yes both HTML and PDF) from your desktop. (mindblowingly non automatic, but that is the way it is under OJS 3.2)
- When in the galleys choose "Change file" to upload
- In "Article Component" choose "Article Text"

# How to do the final stage of publishing

When all galleys are loaded and you are ready to publish the volume, go to 

https://journals.ub.uni-heidelberg.de/index.php/pylon/manageIssues#futureIssues

call up the volume concerned and click on the arrow to the left of the title `Vol. 6 (2024)` then choose and click on “Publish Issue”

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
- Put a tick in all boxes of those "Not Deposited"

Remove tick from 
- “Validate XML before the export and registration.”

Once this is done now

Click on “Register”

# Publishing in stages

Publish let us say first 3 articles. 

When the next batch is ready, simply add these to the existing journal volume. 
- Take care when assigning DOIs
  - Do not click on publish but on the big fat red "X"
  - Handreichung has a description of what then has to be done to avoid problems
 
# Using the OJS system from submission through to publication

A username must be created for all participants. Once this has been done they can access the system.
- So person Z has to contact one of the editors by mail. That editor then has to create a username and password for that person
- once the above has been done the person Z can then upload the submission
- all members of the editorial board will have to have their own username and password.

