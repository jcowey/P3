<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0">
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
    Possible @style for <seg>
    - "font-weight: bold;"
    - "font-style: italic;"
    - "text-decoration: underline;"
    - AND all combinations thereof
    - so far in Pylon, we have seen
        - "font-weight: bold;"
        - "font-style: italic;"
        - "text-decoration: underline;"
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
    Remove alignment @style junk in <p> 
    ================
    ================
    Hyphens between numerals
    ================
    ================
    Dimensions x => × 
    ================
  -->
  <xsl:template match="p">
    <p>
      <xsl:apply-templates select="@*[name() != 'style']"/>
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>
  <xsl:template match="p/text() | bibl/text() | head/text() | cell/text()">
    <xsl:analyze-string select="." regex="\d-\d">
      <xsl:matching-substring>
        <xsl:analyze-string select="replace(., '-', '–')" regex="\sx\s">
          <xsl:matching-substring>
            <xsl:value-of select="concat(' ', normalize-space(replace(., 'x', '×')), ' ')"/>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:analyze-string select="." regex="\sx\s">
          <xsl:matching-substring>
            <xsl:value-of select="concat(' ', normalize-space(replace(., 'x', '×')), ' ')"/>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

  <!--
    ================
    Add xml:ids to line numbers in the editions
    ================
  -->
  <xsl:template match="ab/lb">
    <xsl:copy>
      <xsl:attribute name="xml:id">
        <xsl:value-of select="concat(ancestor::div/@xml:id, 'ln', @n)"/>
      </xsl:attribute>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!--
    ================
    repository => collection 
    (and adding other requisite msIdentifier elements)
    ================
  -->
  <xsl:template match="msIdentifier">
    <msIdentifier>
      <placeName>
        <settlement/>
      </placeName>
      <collection/>
      <idno type="invNo">
        <xsl:value-of select="./idno[@type = 'invNo']"/>
      </idno>
    </msIdentifier>

  </xsl:template>
  
  <!--
    ================
    Trimming <ref[@target="https://papyri.info/...]"> 
    urls of unwanted search junk
    ================
  -->
  
  <xsl:template match="ref[contains(@target, 'papyri.info') and contains(@target, '?')]">
    <ref>
      <xsl:attribute name="target">
        <xsl:value-of select="substring-before(@target, '?')"/>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </ref>
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
  

  <!--
    ================
    Hyperlink automated lookup: NOT YET OPERATIONAL
    ================
    <xsl:key name="idnoLookup" match="file" use="idno[@type='ddb-hybrid']" />
       
    ================
    Conversion to 'smart' quotes and curly apostrophes
    ================
      <xsl:analyze-string select="." regex="[&quot;'']">
      <xsl:matching-substring>
        <xsl:value-of select="replace(., '-', '–') ! normalize-space()"/>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>  
  -->


</xsl:stylesheet>
