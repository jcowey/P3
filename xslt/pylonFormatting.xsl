<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
  <!--2018-06-13 ebb: XSLT-Identity Transformation Starter (non-namespaced XML)
  Template provided by Elisa Beshero-Bondar for the 2024 Digital Humanities Summer Institute, University of Victoria
  Developed by C.M. Sampson to provide additional processing of Pylon XML, following conversion by Hugh Cayless's .docx to .xml converter (https://github.com/hcayless/P3-processing) 
  -->

  <xsl:output method="xml" indent="yes"/>

  <xsl:mode on-no-match="shallow-copy"/>

  <!--
    ================
    <seg> wrangling
    ================
    
    - <seg style="font-weight: bold;"> => <emph rend="bold"> 
    - <seg style="font-style: italic;"> => <emph rend="italics">
    - <seg style="text-decoration: underline;"> => <emph rend="underlined">
    
    - NB: combinations are possible, e.g.
        - "font-weight: bold;text-decoration: underline;"
        - "font-style: italic;text-decoration: underline;"
        - "font-style: italic;font-weight: bold;"
-->

  <xsl:template match="seg[@style = 'font-style: italic;']">
    <emph rend="italics">
      <xsl:apply-templates select=". ! normalize-space()"/>
    </emph>
  </xsl:template>
  <xsl:template match="seg[@style = 'font-weight: bold;']">
    <emph rend="bold">
      <xsl:apply-templates select=". ! normalize-space()"/>
    </emph>
  </xsl:template>
  <xsl:template match="seg[@style = 'text-decoration: underline;']">
    <emph rend="underlined">
      <xsl:apply-templates select=". ! normalize-space()"/>
    </emph>
  </xsl:template>

  <!--
    ================
    Remove @style from <p> 
    ================
  -->
  <xsl:template match="p">
    <p>
      <xsl:apply-templates select="@*[name() != 'style']"/>
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>
  <!--
    ================
    En-dash between numerals instead of hyphens 
    ================
  -->
  <xsl:template match="p/text() | bibl/text()">
    <xsl:analyze-string select="." regex="\d-\d">
      <xsl:matching-substring>
        <xsl:value-of select="replace(., '-', '–') ! normalize-space()"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>

    <!--
      ================
      Conversion to 'smart' quotes and curly apostrophes
      NOT YET OPERATIONAL
      ================
      <xsl:key name="idnoLookup" match="file" use="idno[@type = 'ddb-hybrid']"/>
      <xsl:analyze-string select="." regex="[&quot;'']">
      <xsl:matching-substring>
        <xsl:value-of select="replace(., '-', '–') ! normalize-space()"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>-->
  </xsl:template>

  <!--
    ================
    Trimming <ref target="https://papyri.info/biblio/"> 
    of unwanted search junk
    ================
  -->

  <xsl:template match="ref[matches(@target, 'papyri.info/biblio/\d+\?')]">
    <ref>
      <xsl:attribute name="target">
        <xsl:value-of select="substring-before(@target, '?')"/>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </ref>
  </xsl:template>

  <!--
    ================
    Duplicate any div[@type="edition"]
    adding @subtype/PN or @subtype/Pylon
    PN will not have an xml:id and will therefore be ignored by HEIeditions XSLT
    ================
  -->

  <xsl:template match="div[@type = 'edition'][not(.[@copyOf])]">

    <xsl:copy>
      <xsl:attribute name="subtype">PN</xsl:attribute>
      <xsl:apply-templates select="@*[not(name() = 'xml:id')] | node()"/>
    </xsl:copy>


    <xsl:element name="div">
      <xsl:attribute name="subtype">Pylon</xsl:attribute>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <!--
    ================
    Remove xml:space="preserve" from <ref>
    ================
  -->
  
  <xsl:template match="ref">
    <ref>
      <xsl:apply-templates select="@*[name() != 'xml:space']"/>
      <xsl:apply-templates select="node()"/>
    </ref>
  </xsl:template>

 


</xsl:stylesheet>
