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

    <xsl:template match="/">

        <!--
    ================
    Biblio
    ================
    -->

        <!--NB: confirm location of the output folder on the local directory tree for xsl:result-document-->
        <xsl:result-document href="../../papyri/idp.data/Biblio/97/{$biblio}.xml" method="xml">
            <TEI>
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
                    <xsl:for-each select="TEI/TEI[descendant::keywords[@scheme = 'hgv']]">
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
                                    <xsl:value-of select="./descendant::idno[@type = 'dclp-hybrid']/(tokenize(., ';'))[1]"/>
                                </title>
                                <biblScope type="vol">
                                    <xsl:number value="./descendant::idno[@type = 'dclp-hybrid']/(tokenize(., ';'))[2]"/>
                                </biblScope>
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
            </TEI>
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
            <xsl:result-document href="../../papyri/idp.data/HGV_meta_EpiDoc/HGV{$outputFolder}/{$tm}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.13/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI>
                <xsl:attribute name="xml:id">
                    <xsl:text>hgv</xsl:text>
                    <xsl:value-of select="$tm"/>
                </xsl:attribute>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>
                                <xsl:value-of select=".//titleStmt/title"/>
                            </title>
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
                                                <material>
                                                  <xsl:value-of select=".//sourceDesc//material"/>
                                                </material>
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
                        <change who="https://papyri.info/editor/users/HGV">
                            <xsl:attribute name="when"><xsl:value-of select="current-date()"
                                /></xsl:attribute>Xwalk from Pylon</change>
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
                                    <xsl:if test="contains(//idno[@type = 'ddb-filename'][ancestor::TEI[parent::TEI]], '_')">
                                        <biblScope n="4" type="number">
                                            <xsl:text>Nr. </xsl:text>
                                            <xsl:value-of select=".//idno[@type = 'ddb-filename']/string() ! substring-after(., '_')"/>
                                        </biblScope>
                                    </xsl:if>
                                </bibl>
                            </listBibl>
                        </div>
                        <xsl:if test=".//text/body/div[@type = 'commentary']">
                            <xsl:apply-templates select=".//text/body/div[@type = 'commentary']"/>
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@type = 'illustrations']">
                            <xsl:apply-templates select=".//text/body/div[@type = 'illustrations']"
                            />
                        </xsl:if>
                        <xsl:if test=".//text/body/div[@type = 'figure']">
                            <xsl:apply-templates select=".//text/body/div[@type = 'figure']"/>
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
            <xsl:result-document href="../../papyri/idp.data/DCLP/{$outputFolder}/{$tm}.xml" method="xml">
                <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.23/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
                <TEI xml:lang="en">
                    <xsl:attribute name="xml:id">
                        <xsl:text>m</xsl:text>
                        <xsl:value-of select="$tm"/>
                    </xsl:attribute>
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <xsl:apply-templates select=".//titleStmt/title"/>
                            </titleStmt>
                        </fileDesc>
                        <publicationStmt>
                            <authority>
                                <xsl:text>Digital Corpus of Literary Papyri</xsl:text>
                            </authority>
                            <idno type="TM">
                                <xsl:value-of select="$tm"/>
                            </idno>
                            <idno type="filename">
                                <xsl:value-of select="$tm"/>
                            </idno>
                            <idno type="dclp">
                                <xsl:value-of select="$tm"/>
                            </idno>
                            <!--Do I need to construct this idno?-->
                            <idno type="dclp-hybrid">
                                <xsl:value-of select=".//idno[@type = 'dclp-hybrid']"/>
                            </idno>
                            <availability>
                                <p>© Digital Corpus of Literary Papyri. This work is licensed under a <ref type="license" target="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</ref>.</p>
                            </availability>
                        </publicationStmt>
                        <sourceDesc>
                            <msDesc>
                                <msIdentifier>
                                    <xsl:apply-templates select=".//msIdentifier/idno"/>
                                </msIdentifier>
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc>
                                            <xsl:apply-templates select=".//supportDesc//support"/>
                                        </supportDesc>
                                    </objectDesc>
                                </physDesc>
                                <xsl:apply-templates select=".//history"/>
                            </msDesc>
                        </sourceDesc>
                        <encodingDesc>
                            <p>This file encoded to comply with EpiDoc Guidelines and Schema version 8 <ref>http://www.stoa.org/epidoc/gl/5/</ref></p>
                        </encodingDesc>
                        <profileDesc>
                            <textClass>
                                <keywords>
                                    <xsl:comment>Consult TM for assigned keywords</xsl:comment>
                                    <term/>
                                    <term type="culture"/>
                                    <term type="religion"/>
                                </keywords>
                            </textClass>
                            <langUsage>
                                <language ident="en">English</language>
                                <language ident="grc">Greek</language>
                            </langUsage>
                        </profileDesc>
                        <revisionDesc>
                            <change who="https://papyri.info/editor/users/DCLP">
                                <xsl:attribute name="when">
                                    <xsl:value-of select="current-date()"/>
                                </xsl:attribute>Xwalk from Pylon
                            </change>
                        </revisionDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <xsl:apply-templates select=".//div[@type = 'edition'][@xml:space = 'preserve']"/>
                            <div type="bibliography" subtype="principalEdition">
                                <listBibl>
                                    <bibl n="1" type="publication" subtype="principal">
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
                            <xsl:comment>Confirm author/work with CTS etc, in which case, supply div[@type='bibliography'][@subtype='ancientEdition']</xsl:comment>
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
            <xsl:result-document href="../../papyri/idp.data/DDB_EpiDoc_XML/{$ddbSeries}/{concat($ddbSeries, '.', $ddbVolume)}/{$ddbFilename}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.16/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI xml:lang="en">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <xsl:apply-templates select=".//titleStmt/title"/>
                        </titleStmt>
                        <publicationStmt>
                            <authority>Duke Collaboratory for Classics Computing (DC3)</authority>
                            <idno type="filename">
                                <xsl:value-of select="$ddbFilename"/>
                            </idno>
                            <idno type="ddb-hybrid">
                                <xsl:value-of select=".//idno[@type = 'ddb-hybrid']"/>
                            </idno>
                            <idno type="HGV">
                                <xsl:value-of select=".//idno[@type = 'HGV']"/>
                            </idno>
                            <idno type="TM">
                                <xsl:value-of select=".//idno[@type = 'TM']"/>
                            </idno>
                            <availability>
                                <p>© Duke Databank of Documentary Papyri. This work is licensed under a <ref type="license" target="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</ref>.</p>
                            </availability>
                        </publicationStmt>
                        <sourceDesc>
                            <p/>
                        </sourceDesc>
                    </fileDesc>
                    <profileDesc>
                        <langUsage>
                            <language ident="en">English</language>
                            <language ident="grc">Greek</language>
                            <language ident="la">Latin</language>
                        </langUsage>
                    </profileDesc>
                    <revisionDesc>
                        <change who="https://papyri.info/editor/users/DDBDP">
                            <xsl:attribute name="when">
                                <xsl:value-of select="current-date()"/>
                            </xsl:attribute>Xwalk from Pylon
                        </change>
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
            <xsl:result-document href="../../papyri/idp.data/HGV_trans_EpiDoc/{$tm}.xml" method="xml">
            <xsl:processing-instruction name="xml-model">href="https://epidoc.stoa.org/schema/8.13/tei-epidoc.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <TEI xml:lang="en">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>
                                <xsl:apply-templates select=".//titleStmt/title"/>
                            </title>
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
                        <change who="https://papyri.info/editor/users/HGV">
                            <xsl:attribute name="when">
                                <xsl:value-of select="current-date()"/>
                            </xsl:attribute>Xwalk from Pylon
                        </change>
                    </revisionDesc>
                </teiHeader>
                <xsl:apply-templates select=".//body"/>
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
        <xsl:element name="lb">
            <xsl:apply-templates select="@*[name() != 'xml:id']"/>
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
        <xsl:element name="div">
            <xsl:apply-templates
                select="@*[name() != 'xml:id' and name() != 'part' and name() != 'org' and name() != 'sample']"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
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
