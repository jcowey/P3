<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:hei="https://digi.ub.uni-heidelberg.de/schema/tei/heiEDITIONS"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs hei" version="3.0">
    <!--2018-06-13 ebb: XSLT-Identity Transformation Starter (non-namespaced XML)
  Template provided by Elisa Beshero-Bondar for the 2024 Digital Humanities Summer Institute, University of Victoria
  Developed by C.M. Sampson to provide post-publication processing of Pylon XML to facilitate data transfer to papyri.info. For pre-publication processing, see pylonFormatting.xsl
  -->

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="processing-instruction('xml-model')"/>
    <xsl:variable name="biblio" as="element()" select="/TEI[1]/teiHeader/fileDesc/publicationStmt/idno[3]"/>
    <xsl:variable name="when" select="format-dateTime(current-dateTime(), '[Y,4]-[M,2]-[D,2]T[H]:[m]:[s][Z]')"/>
    <xsl:variable name="whenHGV" select="format-dateTime(current-dateTime(), '[Y,4]-[M,2]-[D,2]')"/>

    <xsl:template match="/">

        <!--
    ================
    Biblio
    ================
    -->

        <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document-->
        <xsl:variable name="outputFolder" select="xs:integer($biblio div 1000) + 1"/>
        <xsl:result-document href="../../../../../GitHub/papyri/idp.data/Biblio/{$outputFolder}/{$biblio}.xml" method="xml">    
                <bibl type="article" subtype="journal">
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="/TEI/@xml:lang"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:id">
                        <xsl:text>b</xsl:text>
                        <xsl:value-of select="$biblio"/>
                    </xsl:attribute>
                    <title>
                        <xsl:attribute name="level">a</xsl:attribute>
                        <xsl:attribute name="type">main</xsl:attribute>
                        <xsl:value-of select="./TEI/teiHeader/fileDesc/titleStmt/title"/>
                    </title>
                    <xsl:for-each select="//titleStmt/author">
                        <author n="{count(preceding-sibling::author) + 1}">
                            <xsl:apply-templates select="name/forename"/>
                            <xsl:apply-templates select="name/surname"/>
                        </author>
                    </xsl:for-each>
                    <date>
                        <xsl:value-of select="//imprint/date"/>
                    </date>
                    <biblScope type="issue">
                        <xsl:value-of select="//imprint/biblScope[@unit = 'volume']"/>
                    </biblScope>
                    <biblScope>
                        <xsl:attribute name="type">article</xsl:attribute>
                        <xsl:attribute name="n">
                            <xsl:value-of select="//imprint/biblScope[@unit = 'article']"/>
                        </xsl:attribute>
                        <xsl:text>Article </xsl:text>
                        <xsl:value-of select="//imprint/biblScope[@unit = 'article']"/>
                    </biblScope>
                    <ptr>
                        <xsl:attribute name="target">
                            <xsl:value-of select="//publicationStmt/idno[@ana = 'hc:DOI']"/>
                        </xsl:attribute>
                    </ptr>
                    <relatedItem type="appearsIn" n="1">
                        <bibl>
                            <ptr target="https://papyri.info/biblio/2374"/>
                        </bibl>
                    </relatedItem>
                    <idno type="pi">
                        <xsl:value-of select="$biblio"/>
                    </idno>
                    <xsl:for-each select="TEI/TEI[descendant::idno[@type = 'ddb-filename']]">
                        <relatedItem type="mentions">
                            <xsl:attribute name="n">
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <bibl>
                                <title level="s" type="short">
                                    <xsl:choose>
                                        <xsl:when test="contains(./descendant::idno[@type='ddb-hybrid']/(tokenize(., ';'))[1], 'pylon')">Pylon</xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./descendant::idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[1]"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </title>
                                <biblScope type="vol">
                                    <xsl:number
                                        value="./descendant::idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[2]"/>
                                </biblScope>
                                <!--NB: The following currently confuses @type="num" and what I suspect should be @type="article"-->
                                <biblScope type="num">
                                    <xsl:choose>
                                        <xsl:when test="contains(./descendant::idno[@type = 'ddb-hybrid'], '_')">
                                            <xsl:number value="./descendant::idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[3] ! string() ! substring-before(., '_')"
                                            />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./descendant::idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[3]"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </biblScope>
                                <idno type="ddb">
                                    <xsl:value-of select="descendant::idno[@type = 'ddb-hybrid']"/>
                                </idno>
                                <idno type="tm">
                                    <xsl:value-of select="descendant::idno[@type = 'TM']"/>
                                </idno>
                                <idno type="invNo">
                                    <xsl:value-of select="./descendant::sourceDesc/descendant::idno[@type = 'invNo']"/>
                                </idno>
                            </bibl>
                        </relatedItem>
                    </xsl:for-each>
                    <xsl:for-each select="TEI/TEI[descendant::idno[@type = 'dclp']]">
                        <relatedItem type="mentions">
                            <xsl:attribute name="n">
                                <xsl:value-of select="position()"/>
                            </xsl:attribute>
                            <bibl>
                                <title level="s" type="short">
                                    <xsl:choose>
                                    <xsl:when test="contains(./descendant::idno[@type='dclp-hybrid']/(tokenize(., ';'))[1], 'pylon')">Pylon</xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="./descendant::idno[@type = 'dclp-hybrid']/(tokenize(., ';'))[1]"
                                        />
                                    </xsl:otherwise>
                                    </xsl:choose>
                                </title>
                                <xsl:variable name="secondToken" select="tokenize(./descendant::idno[@type = 'dclp-hybrid'], ';')[2]" />
                                <xsl:if test="normalize-space($secondToken)">
                                    <biblScope type="vol">
                                        <xsl:number value="$secondToken"/>
                                    </biblScope>
                                </xsl:if>
                                <biblScope type="num">
                                    <xsl:choose>
                                        <xsl:when test="contains(./descendant::idno[@type = 'dclp-hybrid'], '_')">
                                            <xsl:number value="./descendant::idno[@type = 'dclp-hybrid']/(tokenize(., ';'))[3] ! string() ! substring-before(., '_')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./descendant::idno[@type = 'dclp-hybrid']/(tokenize(., ';'))[3]"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </biblScope>
                                <idno type="dclp">
                                    <xsl:value-of select="descendant::idno[@type = 'dclp-hybrid']"/>
                                </idno>
                            </bibl>
                        </relatedItem>
                    </xsl:for-each>
                </bibl>
        </xsl:result-document>

        <!--
    ================
    HGV
    ================
    -->

        <xsl:for-each select="TEI/TEI[descendant::idno[@type = 'ddb-filename']]">
            <xsl:variable name="tm" as="element()" select="descendant::idno[@type = 'filename']"/>
            <xsl:variable name="outputFolder" select="xs:integer($tm div 1000) + 1"/>
            <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document--> 
            <xsl:result-document href="../../../../../GitHub/papyri/idp.data/HGV_meta_EpiDoc/HGV{$outputFolder}/{$tm}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.13/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI>
                <xsl:attribute name="xml:id">
                    <xsl:text>hgv</xsl:text>
                    <xsl:value-of select="$tm"/>
                </xsl:attribute>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <xsl:apply-templates select=".//titleStmt/title"/>
                        </titleStmt>
                        <publicationStmt>
                            <idno type="TM">
                                <xsl:value-of select="$tm"/>
                            </idno>
                            <idno type="filename">
                                <xsl:value-of select="$tm"/>
                            </idno>
                            <idno type="ddb-filename">
                                <xsl:value-of select=".//idno[@type = 'ddb-filename']"/>
                            </idno>
                            <idno type="ddb-hybrid">
                                <xsl:value-of select=".//idno[@type = 'ddb-hybrid']"/>
                            </idno>
                        </publicationStmt>
                        <sourceDesc>
                            <msDesc>
                                <msIdentifier>
                                    <placeName>
                                        <settlement>
                                            <xsl:choose>
                                                <xsl:when test=".//sourceDesc//settlement">
                                                  <xsl:value-of select=".//sourceDesc//settlement"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                  <xsl:value-of select=".//sourceDesc//idno[@type = 'invNo']/(tokenize(., ', '))[1]"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </settlement>
                                    </placeName>
                                    <collection>
                                        <xsl:choose>
                                            <xsl:when test=".//sourceDesc//collection">
                                                <xsl:value-of select=".//sourceDesc//collection"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select=".//sourceDesc//idno[@type = 'invNo']/(tokenize(., ', '))[2]"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </collection>
                                    <idno type="invNo">
                                        <xsl:choose>
                                            <xsl:when test=".//sourceDesc//idno[@type = 'invNo']">
                                                <xsl:value-of select=".//sourceDesc//idno[@type = 'invNo']"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select=".//sourceDesc//idno[@type = 'invNo']/(tokenize(., ', '))[3]"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </idno>
                                </msIdentifier>
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc>
                                            <support>
                                                <xsl:apply-templates select=".//sourceDesc//material"/>
                                            </support>
                                        </supportDesc>
                                    </objectDesc>
                                </physDesc>
                                <xsl:apply-templates select=".//history"/>
                            </msDesc>
                            <listBibl>
                                <bibl type="SB">
                                    <ptr>
                                        <xsl:attribute name="target">
                                            <xsl:text>https://papyri.info/biblio/</xsl:text>
                                            <xsl:value-of select="$biblio"/>
                                        </xsl:attribute>
                                    </ptr>
                                </bibl>
                            </listBibl>
                        </sourceDesc>
                    </fileDesc>
                    <xsl:apply-templates select=".//encodingDesc"/>
                    <xsl:apply-templates select=".//profileDesc"/>
                    <revisionDesc>
                        <change>
                            <xsl:attribute name="when">
                                <xsl:value-of select="$whenHGV"/>
                            </xsl:attribute>
                            <xsl:attribute name="who">
                                <xsl:text>HGV</xsl:text>
                            </xsl:attribute>
                            <xsl:text>Xwalk from Pylon</xsl:text>
                        </change>
                    </revisionDesc>
                </teiHeader>
                <text>
                    <body>
                        <div type="bibliography" subtype="principalEdition">
                            <listBibl>
                                <bibl type="publication" subtype="principal">
                                    <title level="s" type="abbreviated">Pylon</title>
                                    <biblScope n="1" type="volume">
                                        <xsl:value-of select="//imprint/biblScope[@unit = 'volume']"/>
                                    </biblScope>
                                    <biblScope n="2" type="fascicle">
                                        <xsl:text>(</xsl:text>
                                        <xsl:value-of select="//imprint/date"/>
                                        <xsl:text>)</xsl:text>
                                    </biblScope>
                                    <biblScope n="3" type="generic">
                                        <xsl:text>Art. </xsl:text>
                                        <xsl:value-of select="//imprint/biblScope[@unit = 'article']"/>
                                    </biblScope>
                                    <xsl:if test="contains(., '_')">
                                        <biblScope n="4" type="number">
                                            <xsl:text>Nr. </xsl:text>
                                            <xsl:value-of select=".//idno[@type = 'ddb-filename']/string() ! substring-after(., '_')"/>
                                        </biblScope>
                                    </xsl:if>
                                </bibl>
                            </listBibl>
                        </div>
                        <xsl:if test=".//text/body/div[@subtype = 'illustrations']">
                            <xsl:apply-templates select=".//text/body/div[@subtype = 'illustrations']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@subtype = 'otherPublications']">
                            <xsl:apply-templates select=".//text/body/div[@subtype = 'otherPublications']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@subtype = 'general']">
                            <xsl:apply-templates select=".//text/body/div[@subtype = 'general']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@subtype = 'translations']">
                            <xsl:apply-templates select=".//text/body/div[@subtype = 'translations']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@type = 'figure']">
                            <xsl:apply-templates select=".//text/body/div[@type = 'figure']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@subtype = 'corrections']">
                            <xsl:apply-templates select=".//text/body/div[@subtype = 'corrections']"/>
                        </xsl:if>
                    </body>
                </text>
            </TEI>
            </xsl:result-document>
        </xsl:for-each>

        <!--
    ================
    DCLP
    ================
    -->

        <xsl:for-each select="TEI/TEI[descendant::idno[@type = 'dclp']]">
            <xsl:variable name="tm" as="element()" select="descendant::idno[@type = 'filename']"/>
            <xsl:variable name="outputFolder" select="xs:integer($tm div 1000) + 1"/>
            <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document-->
            <xsl:result-document href="../../../../../GitHub/papyri/idp.data/DCLP/{$outputFolder}/{$tm}.xml" method="xml">
                <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.23/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
                <TEI xml:lang="en">
                    <xsl:attribute name="xml:id">
                        <xsl:text>m</xsl:text>
                        <xsl:value-of select="$tm"/>
                    </xsl:attribute>
                    <teiHeader>
                        <xsl:apply-templates select=".//fileDesc"/>
                        <xsl:apply-templates select=".//encodingDesc"/>
                        <xsl:apply-templates select=".//profileDesc"/>
                        <revisionDesc>
                            <change>
                                <xsl:attribute name="when">
                                    <xsl:value-of select="$when"/>
                                </xsl:attribute>
                                <xsl:attribute name="who">
                                    <xsl:text>DCLP</xsl:text>
                                </xsl:attribute>
                                <xsl:text>Xwalk from Pylon</xsl:text></change>
                            <xsl:apply-templates select=".//change"/>
                        </revisionDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <xsl:apply-templates select=".//div[@type = 'edition'][@xml:space = 'preserve']"/>
                            <div type="bibliography" subtype="principalEdition">
                                <listBibl>
                                    <xsl:apply-templates select=".//div[@type='bibliography'][@subtype='principalEdition']/listBibl/bibl"/>
                                    <bibl type="publication" subtype="principal">
                                        <ptr>
                                            <xsl:attribute name="target">
                                                <xsl:text>https://papyri.info/biblio/</xsl:text>
                                                <xsl:value-of select="$biblio"/>
                                            </xsl:attribute>
                                        </ptr>
                                        <xsl:comment>Confirm other bibliography</xsl:comment>
                                    </bibl>
                                </listBibl>
                            </div>
                            <xsl:if test="../text/descendant::figure/ptr">
                                <div type="bibliography" subtype="illustrations">
                                    <listBibl>
                                        <xsl:apply-templates select=".//div[@type='bibliography'][@subtype='illustrations']/listBibl/bibl"/>
                                        <bibl type="online">
                                            <ptr>
                                                <xsl:attribute name="target">
                                                  <xsl:value-of select="../descendant::publicationStmt/idno[@ana = 'hc:DOI']"/>
                                                </xsl:attribute>
                                            </ptr>
                                        </bibl>
                                    </listBibl>
                                </div>
                            </xsl:if>
                            <xsl:if test=".//div[@type='bibliography'][@subtype='ancientEdition']">
                                <xsl:apply-templates select=".//div[@type='bibliography'][@subtype='ancientEdition']"/>
                            </xsl:if>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>

        <!--
    ================
    DDB
    ================
    -->

        <xsl:for-each select="TEI/TEI[descendant::idno[@type = 'HGV']][descendant::ab]">
            <xsl:variable name="ddbSeries" as="xs:string" select="descendant::publicationStmt/idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[1]"/>
            <xsl:variable name="ddbVolume" as="xs:string" select="descendant::publicationStmt/idno[@type = 'ddb-hybrid']/(tokenize(., ';'))[2]"/>
            <xsl:variable name="ddbFilename" as="element()" select="descendant::idno[@type = 'filename']"/>
            <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document-->
            <xsl:result-document href="../../../../../GitHub/papyri/idp.data/DDB_EpiDoc_XML/{$ddbSeries}/{concat($ddbSeries, '.', $ddbVolume)}/{$ddbFilename}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.16/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI xml:lang="en">
                <teiHeader>
                    <xsl:apply-templates select=".//fileDesc"/>
                    <xsl:apply-templates select=".//profileDesc"/>
                    <revisionDesc>
                        <change>
                            <xsl:attribute name="when">
                                <xsl:value-of select="$when"/>
                            </xsl:attribute>
                            <xsl:attribute name="who">DDbDP</xsl:attribute>
                            <xsl:text>Xwalk from Pylon</xsl:text></change>
                    </revisionDesc>
                </teiHeader>
                <text>
                    <body>
                        <xsl:apply-templates select=".//div[@type = 'edition'][@xml:space = 'preserve'][1]"/>
                    </body>
                </text>
            </TEI>
            </xsl:result-document>
        </xsl:for-each>

        <!--
    ================
    HGV Translation
    ================
    -->

        <xsl:for-each select="TEI/TEI[descendant::div[@type = 'translation']]">
            <xsl:variable name="tm" as="element()" select="descendant::idno[@type = 'TM']"/>
            <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document-->
            <xsl:result-document href="../../../../GitHub/papyri/idp.data/HGV_trans_EpiDoc/{$tm}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.13/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI xml:lang="en">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <xsl:apply-templates select=".//titleStmt/title"/>
                        </titleStmt>
                        <publicationStmt>
                            <idno type="filename">
                                <xsl:value-of select=".//idno[@type = 'filename']"/>
                            </idno>
                            <idno type="TM">
                                <xsl:value-of select="$tm"/>
                            </idno>

                            <idno type="HGV">
                                <xsl:value-of select=".//idno[@type = 'HGV']"/>
                            </idno>
                            <idno type="ddb-hybrid">
                                <xsl:value-of select=".//idno[@type = 'ddb-hybrid']"/>
                            </idno>
                            <availability>
                                <p>© Heidelberger Gesamtverzeichnis der griechischen Papyrusurkunden Ägyptens. This work is licensed under a <ref target="http://creativecommons.org/licenses/by/3.0/" type="license">Creative Commons Attribution 3.0 License</ref>.</p>
                            </availability>
                        </publicationStmt>
                        <sourceDesc>
                            <p>The contents of this document are generated from SOSOL.</p>
                        </sourceDesc>
                    </fileDesc>
                    <profileDesc>
                        <langUsage>
                            <language ident="fr">French</language>
                            <language ident="en">English</language>
                            <language ident="de">German</language>
                            <language ident="it">Italian</language>
                            <language ident="es">Spanish</language>
                            <language ident="la">Latin</language>
                            <language ident="el">Modern Greek</language>
                            <language ident="ar">Arabic</language>
                        </langUsage>
                    </profileDesc>
                    <revisionDesc>
                        <change>
                            <xsl:attribute name="when">
                                <xsl:value-of select="$when"/>
                            </xsl:attribute>
                            <xsl:attribute name="who">HGV</xsl:attribute>
                            <xsl:text>Xwalk from Pylon</xsl:text></change>
                    </revisionDesc>
                </teiHeader>
                <xsl:apply-templates select=".//text"/>
            </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <!--
    ================
    Remove @xml:id from <lb>
    ================
    -->
    <xsl:template match="lb">
        <xsl:text>&#xA;</xsl:text>
        <xsl:element name="lb">
            <xsl:apply-templates select="@*[name() != 'xml:id' and name() != 'facs']"/>
        </xsl:element>
    </xsl:template>
    
    <!--
    ================
    Remove @status from <bibl>
    ================
    -->
    <xsl:template match="bibl">
        <xsl:text>&#xA;</xsl:text>
        <xsl:element name="bibl">
            <xsl:apply-templates select="node()|@*[name() != 'status' and name() != 'default']"/>
        </xsl:element>
    </xsl:template>
    
    <!--
    ================
    milestone, ab, and p begin on new lines
    ================
    -->
    <xsl:template match="milestone | p | ab">
        <xsl:text>&#xA;</xsl:text>
        <xsl:element name="{name()}">
            <xsl:apply-templates select="node()|@*[name() != 'part']"/>
        </xsl:element>
    </xsl:template>

    <!--
    ================
    Remove <note> children of <ab>
    ================
    -->
    <xsl:template match="ab/note"/>

    <!--
    ================
    Remove @xml:id etc. from edition <div>
    ================
    -->
    <xsl:template match="div">
        <xsl:text>&#xA;</xsl:text>
        <xsl:element name="div">
            <xsl:apply-templates
                select="@*[name() != 'xml:id' and name() != 'part' and name() != 'org' and name() != 'sample']"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <!--
    ================
    Remove <table> descendants of <ab>
    ================
    -->
    <xsl:template match="ab/descendant::table">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!--
    ================
    Remove <cell> descendants of <ab>
    ================
    -->
    <xsl:template match="ab/descendant::cell">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!--
    ================
    Rename <row> descendants of <ab> as the <lb/> and preserve @n value
    ================
    -->
    <xsl:template match="ab/descendant::row">
        <xsl:text>&#xA;</xsl:text>
        <lb n="{@n}"/>
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!--
    ================
    Copy attributes by default 
    ================
    -->
    <xsl:template match="@*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
        </xsl:copy>
    </xsl:template>

    <!--
    ================
    Strip xmlns:hei etc. 
    ================
    -->

    <xsl:template match="*">
        <xsl:element name="{local-name()}" xmlns="http://www.tei-c.org/ns/1.0"
            xmlns:hei="https://digi.ub.uni-heidelberg.de/schema/tei/heiEDITIONS">
            <xsl:copy-of
                select="@*[not(name() = 'instant' or name() = 'full' or name() = 'part' or name() = 'default' or name() = 'sample' or name() = 'org')]"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--
    ================
    replacing | with <lb n="\d+" break="no"/> in a regularization
    (limitations of heiEditions XSLT requires the manual addition of | to make the apparatus clear)
    currently works within <reg>, but NB: this also appears within lem/@resp too, where it will be harder to wrangle
    ================
    -->

    <xsl:template match="reg//text()">
        <xsl:variable name="n-value" select="ancestor::reg/following-sibling::orig/lb[1]/@n"/>
        <xsl:call-template name="replace-pipe">
            <xsl:with-param name="text" select="."/>
            <xsl:with-param name="n-value" select="$n-value"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="replace-pipe">
        <xsl:param name="text" select="."/>
        <xsl:param name="n-value"/>
        <xsl:choose>
            <xsl:when test="contains($text, '|')">
                <xsl:value-of select="substring-before($text, '|')"/>
                <lb break="no" n="{$n-value}"/>
                <xsl:call-template name="replace-pipe">
                    <xsl:with-param name="text" select="substring-after($text, '|')"/>
                    <xsl:with-param name="n-value" select="$n-value"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>




    <!--The following isn't going to work for pipes within lem/@resp, unfortunately
    <xsl:template match="lem//text()">
        <xsl:variable name="n-value" select="ancestor::lem/parent::app/following-sibling::lb[1]/@n"/>
        <xsl:call-template name="replace-pipe">
            <xsl:with-param name="text" select="."/>
            <xsl:with-param name="n-value" select="$n-value"/>
        </xsl:call-template>
    </xsl:template>
    -->

</xsl:stylesheet>
