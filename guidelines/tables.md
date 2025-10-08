# Tables

## Cell width problems

There have been problems with the width of cells in tables in Pylon articles. 

In the case of the article by Kovarik in Pylon 7 the following [table](https://journals.ub.uni-heidelberg.de/index.php/pylon/article/view/112020/107699#tab2) was made acceptable by reducing the percentage on @style="font-size":
- see `<table style="font-size: 80%;">` at https://gitlab.ub.uni-heidelberg.de/verlag/xmlworkflow_zs_pylon/-/blob/main/epidoc/7/112020.xml?ref_type=heads#L299
- this is the issue, [200](https://gitlab.ub.uni-heidelberg.de/verlag/PapyrologicalPublicationPlatform/-/issues/200), used to solve the problem.

Here is another outstanding issue: https://gitlab.ub.uni-heidelberg.de/verlag/PapyrologicalPublicationPlatform/-/issues/180

