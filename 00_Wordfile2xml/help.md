# wordfile to XML

## Basic introduction to the process of preparing the wordfile before it is uploaded to P3-processing.

Once the word file has been vetted and is satisfactory for the editorial board and the author, make sure the following things are as complete as possible.

- All cited texts and bibliography have embedded links in the word file. Clean links make life much easier. This is something that the authors really ought to do. Some authors are really good about this. Others are lazy. To save work for the conversions it is better to ask the author to make a proper job of this.
- Make sure that all cited bibliography has a corresponding biblio link in papyri.info. Authors should be encouraged to make clear which bibliographical references do not have a corresponding biblio record in papyri.info. (At present the biblio entry mask is not functional)
- Any embedded jpgs / images must be taken out of the word file. Anchors with the fig. numbers should be inserted in the file (this helps later for setting the figure XML in the P3-processed file)

### Further preparation for P3-processing

- Follow the guidelines for mark up of the text (in some cases this will have been done by contributors - again some are good at this - for others it has to be done for them): [see these guidelines](https://github.com/jcowey/P3/blob/master/guidelines/structuralMarkUp_documentary.md). There are also [Templates](https://github.com/jcowey/P3/blob/master/guidelines/templates.md), which might be helpful to look at.
- Now make sure that the file, which has been prepared and saved, has a `.docx` suffix on it.
- The file is now ready to be uploaded to [P3-processing](https://github.com/hcayless/P3-processing)
- I have found it helpful to prefix each file with the number of the pylon volume and then a clear indication of the author, thus e.g. `10pylon_balamoshev.docx`, but, of course, everyone has their own way of making it possible to find output files within the list of files already processed for earlier volumes

### Use of P3-processing

- When at [P3-processing](https://github.com/hcayless/P3-processing) click on `sources` - [here](https://github.com/hcayless/P3-processing/tree/main/sources)
- Now click on `Add file` (top right hand corner) and choose `Upload files` then navigate on your computer to where the file is stored and double click on it.
- Remember to add a note in the box e.g. Added new file.
- One then has to wait about 20 seconds, sometimes a bit longer. If everything has been transformed the corresponding XML file can then be found in the folder `articles` [here](https://github.com/hcayless/P3-processing/tree/main/articles)
