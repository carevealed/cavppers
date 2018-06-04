<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:p="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:str="http://exslt.org/strings" version="1.0" extension-element-prefixes="xsi str p">
  <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="/csv">
    <metadata xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:dcterms='http://purl.org/dc/terms/'>
      <xsl:apply-templates select="row[starts-with(col2,$select)]"/>
    </metadata>
  </xsl:template>
  <xsl:template match="row">
    <pbcoreDescriptionDocument>
      <!-- the columns to map are listed below. They should be in the right order as expected in the output. I grouped them by pbcore element.
      All values listed below must also be referenced by a function below.-->
      
      <xsl:apply-templates select="col1"/><!-- identifier -->
      <dc:description>California Revealed</dc:description>
      <xsl:apply-templates select="col67|col68"/><!-- descriptions -->
      <xsl:apply-templates select="col6"/><!-- source -->
      <dc:type>Moving Image</dc:type><!-- how should this be formatted -->
      <xsl:apply-templates select="col10|col11|col12"/><!-- titles -->
      <xsl:apply-templates select="col15|col16|col17|col18|col19|col20"/><!-- creator -->
      <xsl:apply-templates select="col22|col23"/><!-- Dates -->
      <xsl:apply-templates select="col24|col60|col61|col62|col63|col64"/><!-- rights -->
      <xsl:apply-templates select="col41"/><!-- language -->
      <xsl:apply-templates select="col42|col43"/><!-- subjects -->
      <Assets>
        <xsl:apply-templates select="col2"/><!-- object identifier -->
        <xsl:apply-templates select="col4"/><!-- project identifier -->
        <xsl:apply-templates select="col7"/><!-- Asset Type -->
        <xsl:apply-templates select="col13"/><!-- descriptions -->
      </Assets>

      <!--
      <xsl:apply-templates select="col3|col65|col69"/><!-- identifiers ->
      <xsl:apply-templates select="col44"/><!-- genre ->
      <xsl:apply-templates select="col30|col31|col32|col33|col34|col35|col36|col37|col38"/><!-- contributor ->
      <xsl:apply-templates select="col39|col40"/><!-- publisher ->

      <xsl:if test="$instantiations_original">
        <xsl:comment>Original Asset</xsl:comment>
      </xsl:if>
      <xsl:for-each select="str:tokenize($instantiations_original,'+')">
        <pbcoreInstantiation>
          <xsl:copy-of select="document(normalize-space(.))/p:pbcoreInstantiationDocument/node()"/>
        </pbcoreInstantiation>
      </xsl:for-each>
      <xsl:if test="$instantiations_prsv">
        <xsl:comment>Preservation Master</xsl:comment>
      </xsl:if>
      <xsl:for-each select="str:tokenize($instantiations_prsv,'+')">
        <pbcoreInstantiation>
          <xsl:copy-of select="document(normalize-space(.))/p:pbcoreInstantiationDocument/node()"/>
        </pbcoreInstantiation>
      </xsl:for-each>
      <xsl:if test="$instantiations_access">
        <xsl:comment>Access Copy</xsl:comment>
      </xsl:if>
      <xsl:for-each select="str:tokenize($instantiations_access,'+')">
        <pbcoreInstantiation>
          <xsl:copy-of select="document(normalize-space(.))/p:pbcoreInstantiationDocument/node()"/>
        </pbcoreInstantiation>
      </xsl:for-each>
      <!-- parts ->
      <xsl:if test="$pbcore_parts">
        <xsl:comment>Parts</xsl:comment>
      </xsl:if>
      <xsl:for-each select="str:tokenize($pbcore_parts,'+')">
        <pbcorePart>
          <xsl:copy-of select="document(normalize-space(.))/p:pbcorePart/p:pbcoreIdentifier"/>
          <xsl:copy-of select="$part-description"/>
          <xsl:for-each select="document(normalize-space(.))/p:pbcorePart/p:pbcoreInstantiation">
            <xsl:choose>
                <xsl:when test="not(./p:instantiationPart/p:instantiationIdentifier[@source='File Name']) and not(./p:instantiationIdentifier[@source='File Name'])">
                  <xsl:comment>Original Asset</xsl:comment>
                </xsl:when>
              <xsl:when test="contains(./p:instantiationIdentifier,'prsv')">
                <xsl:comment>Preservation Master</xsl:comment>
              </xsl:when>
              <xsl:otherwise>
                <xsl:comment>Access Copy</xsl:comment>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </pbcorePart>
      </xsl:for-each>
      <!-- extensions ->
      <xsl:apply-templates select="col5|col21"/><!-- extension ->

    </pbcoreDescriptionDocument>
  </xsl:template>
  -->
  
  <!-- dc TEMPLATES -->
  <!-- ia id -->
  <xsl:template name="identifier-ia" match="col1">
    <xsl:if test="string-length(.)>0">
      <dc:identifier>
        <xsl:attribute name="type">Internet Archive URL</xsl:attribute>
        <xsl:value-of select="."/>
      </dc:identifier>
    </xsl:if>
  </xsl:template>
  <!-- source -->
  <xsl:template name="source" match="col6">
    <xsl:if test="string-length(.)>0">
      <source>
        <xsl:attribute name="type">Owning Institution</xsl:attribute>
        <xsl:value-of select="."/>
      </source>
    </xsl:if>
  </xsl:template>
  <!-- descriptions -->
  <xsl:template name="description" match="col67|col68">
    <xsl:if test="string-length(.)>0">
      <dc:description>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="type">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </dc:description>
    </xsl:if>
  </xsl:template>
  <xsl:template name="content-summary" match="col13">
    <xsl:if test="string-length(.)>0">
      <descriptionOrContentSummary>
        <xsl:value-of select="."/>
      </descriptionOrContentSummary>
    </xsl:if>
  </xsl:template>
  <!-- titles -->
  <xsl:template name="title" match="col10|col11|col12">
    <xsl:if test="string-length(.)>0">
      <dc:title>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="type">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </dc:title>
    </xsl:if>
  </xsl:template>
  <!-- creators -->
  <xsl:template name="creator" match="col15|col16|col17|col18|col19|col20">
    <xsl:if test="string-length(.)>0">
      <dc:creator>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="type">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </dc:creator>
    </xsl:if>
  </xsl:template>
  <!-- dates -->
  <xsl:template name="date_created" match="col22">
    <xsl:choose>
      <xsl:when test="string-length(.)=10">
        <dc:date>
          <xsl:attribute name="type">Created</xsl:attribute>
          <xsl:value-of select="."/>
        </dc:date>
      </xsl:when>
      <xsl:when test="string-length(substring(.,3,string-length(.)-3))>0">
        <dc:date>
          <xsl:attribute name="type">Created</xsl:attribute>
          <xsl:value-of select="substring(.,3,string-length(.)-3)"/>
        </dc:date>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="date_published" match="col23">
    <xsl:choose>
      <xsl:when test="string-length(.)=10">
        <dc:date>
          <xsl:attribute name="type">Published</xsl:attribute>
          <xsl:value-of select="."/>
        </dc:date>
      </xsl:when>
      <xsl:when test="string-length(substring(.,3,string-length(.)-3))>0">
        <dc:date>
          <xsl:attribute name="type">Published</xsl:attribute>
          <xsl:value-of select="substring(.,3,string-length(.)-3)"/>
        </dc:date>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- rights -->
  <xsl:template name="rights" match="col24|col60|col61|col63|col64">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <dc:rights>
        <xsl:attribute name="annotation">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </dc:rights>
    </xsl:if>
  </xsl:template>
  <!-- rights with date cleanup thing -->
  <xsl:template name="rights-date" match="col62">
    <xsl:if test="string-length(substring(.,3,string-length(.)-3))>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <dc:rights>
        <xsl:attribute name="type">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="substring(.,3,string-length(.)-3)"/>
      </dc:rights>
    </xsl:if>
  </xsl:template>
  <!-- language -->
  <xsl:template name="language" match="col41">
    <xsl:if test="string-length(.)>0">
      <language>
        <xsl:value-of select="."/>
      </language>
    </xsl:if>
  </xsl:template>
  <!-- subjects -->
  <xsl:template name="subject" match="col42|col43">
    <xsl:if test="string-length(.)>0">
      <dc:subject>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="type">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </dc:subject>
    </xsl:if>
  </xsl:template>
  <!-- object identifier -->
  <xsl:template name="object-identifier" match="col2">
    <xsl:if test="string-length(.)>0">
      <objectIdentifier>
        <xsl:value-of select="."/>
      </objectIdentifier>
    </xsl:if>
  </xsl:template>
  <!-- project identifier -->
  <xsl:template name="project-identifier" match="col4">
    <xsl:if test="string-length(.)>0">
      <projectIdentifier>
        <xsl:value-of select="."/>
      </projectIdentifier>
    </xsl:if>
  </xsl:template>
  <!-- Asset Type -->
  <xsl:template match="col7">
    <xsl:if test="string-length(.)>0">
      <assetType>
        <xsl:value-of select="."/>
      </assetType>
    </xsl:if>
  </xsl:template>
  
  <!-- maybe don't need
  <!-- Dates ->
  
  <xsl:template name="date-instantiation" match="XXX" mode="instantiation">
    <xsl:if test="string-length(.)>0">
      <instantiationDate>
        <xsl:attribute name="dateType">Created</xsl:attribute>
        <xsl:value-of select="."/>
      </instantiationDate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="color-instantiation" match="col29">
    <xsl:if test="string-length(.)>0">
      <instantiationColors>
        <xsl:value-of select="."/>
      </instantiationColors>
    </xsl:if>
  </xsl:template>
  <xsl:template name="tracks-instantiation" match="col28">
    <xsl:if test="string-length(.)>0">
      <instantiationTracks>
        <xsl:value-of select="."/>
      </instantiationTracks>
    </xsl:if>
  </xsl:template>
  <xsl:template name="language-instantiation" match="col41">
    <xsl:if test="string-length(.)>0">
      <instantiationLanguage>
        <xsl:value-of select="."/>
      </instantiationLanguage>
    </xsl:if>
  </xsl:template>
  <xsl:template name="instantiation-annotation-extant" match="col26">
    <xsl:if test="string-length(.)>0">
      <instantiationAnnotation>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="source">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </instantiationAnnotation>
    </xsl:if>
  </xsl:template>
  <!-- identifiers ->
  <xsl:template name="identifier-cavpp" match="col3">
    <xsl:if test="string-length(.)>0">
      <pbcoreIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="annotation">California Revealed</xsl:attribute>
        <xsl:attribute name="source">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </pbcoreIdentifier>
    </xsl:if>
  </xsl:template>

  <xsl:template name="identifier-cavpp-part" match="col2" mode="part">
    <xsl:if test="string-length(.)>0">
      <pbcoreIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="annotation">California Revealed</xsl:attribute>
        <xsl:attribute name="source">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </pbcoreIdentifier>
    </xsl:if>
  </xsl:template>
  <xsl:template name="identifier-institution-url" match="col65">
    <xsl:if test="string-length(.)>0">
      <pbcoreIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="source">Institution</xsl:attribute>
        <xsl:attribute name="annotation">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </pbcoreIdentifier>
    </xsl:if>
  </xsl:template>
  <xsl:template name="identifier-cdl" match="col69">
    <xsl:if test="string-length(.)>0">
      <pbcoreIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="source">CDL</xsl:attribute>
        <xsl:attribute name="annotation">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </pbcoreIdentifier>
    </xsl:if>
  </xsl:template>
  
  

  <!-- genres ->
  <xsl:template name="genre" match="col44">
    <xsl:if test="string-length(.)>0">
      <pbcoreGenre>
        <xsl:attribute name="source">The Moving Image Genre-form Guide</xsl:attribute>
        <xsl:value-of select="."/>
      </pbcoreGenre>
    </xsl:if>
  </xsl:template>
  <!-- coverage ->
  <xsl:template name="coverage-spatial" match="col45">
    <xsl:if test="string-length(.)>0">
      <pbcoreCoverage>
        <coverage>
          <xsl:value-of select="."/>
        </coverage>
        <coverageType>Spatial</coverageType>
      </pbcoreCoverage>
    </xsl:if>
  </xsl:template>
  <xsl:template name="coverage-temporal" match="col46">
    <xsl:if test="string-length(.)>0">
      <pbcoreCoverage>
        <coverage>
          <xsl:value-of select="."/>
        </coverage>
        <coverageType>Temporal</coverageType>
      </pbcoreCoverage>
    </xsl:if>
  </xsl:template>
  
  <!-- contributors ->
  <xsl:template name="contributor" match="col30|col31|col32|col33|col34|col35|col36|col37|col38">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <pbcoreContributor>
        <contributor>
          <xsl:value-of select="."/>
        </contributor>
        <contributorRole>
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </contributorRole>
      </pbcoreContributor>
    </xsl:if>
  </xsl:template>
  <!-- publishers ->
  <xsl:template name="publisher" match="col39|col40">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <pbcorePublisher>
        <publisher>
          <xsl:value-of select="."/>
        </publisher>
        <publisherRole>
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </publisherRole>
      </pbcorePublisher>
    </xsl:if>
  </xsl:template>
  
  <!-- instantiation stuff ->
  <xsl:template name="inst-identifier-cavpp" match="col2" mode="instantiation">
    <xsl:if test="string-length(.)>0">
      <instantiationIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="source">California Revealed</xsl:attribute>
        <xsl:attribute name="annotation">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </instantiationIdentifier>
    </xsl:if>
  </xsl:template>
  <xsl:template name="instantiationPhysical" match="col25">
    <xsl:if test="string-length(.)>0">
      <instantiationPhysical>
        <xsl:value-of select="."/>
      </instantiationPhysical>
    </xsl:if>
  </xsl:template>
  <xsl:template name="instantiationLocation" match="col6">
    <xsl:if test="string-length(.)>0">
      <instantiationLocation>
        <xsl:value-of select="."/>
      </instantiationLocation>
    </xsl:if>
  </xsl:template>
  <xsl:template name="instantiationMediaType" match="col8">
    <xsl:if test="string-length(.)>0">
      <instantiationMediaType>
        <xsl:value-of select="."/>
      </instantiationMediaType>
    </xsl:if>
  </xsl:template>
  <xsl:template name="instantiationGenerations" match="col9">
    <xsl:if test="string-length(.)>0">
      <instantiationGenerations>
        <xsl:value-of select="."/>
      </instantiationGenerations>
    </xsl:if>
  </xsl:template>
  <!-- extension templates ->
  <xsl:template name="extension-country" match="col21">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <pbcoreExtension>
        <extensionWrap>
          <extensionElement>
            <xsl:value-of select="../../row[1]/*[$column]"/>
          </extensionElement>
          <extensionValue>
            <xsl:value-of select="."/>
          </extensionValue>
          <extensionAuthorityUsed>ISO 3166.1</extensionAuthorityUsed>
        </extensionWrap>
      </pbcoreExtension>
    </xsl:if>
  </xsl:template>
  <xsl:template name="extension-cavpp" match="col5">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <pbcoreExtension>
        <extensionWrap>
          <extensionElement>
            <xsl:value-of select="../../row[1]/*[$column]"/>
          </extensionElement>
          <extensionValue>
            <xsl:value-of select="."/>
          </extensionValue>
          <extensionAuthorityUsed>California Revealed</extensionAuthorityUsed>
        </extensionWrap>
      </pbcoreExtension>
    </xsl:if>
  </xsl:template>
  <xsl:template name="extension" match="XXX">
    <xsl:if test="string-length(.)>0">
      <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
      <pbcoreExtension>
        <extensionWrap>
          <extensionElement>
            <xsl:value-of select="../../row[1]/*[$column]"/>
          </extensionElement>
          <extensionValue>
            <xsl:value-of select="substring-before(concat(., '('), '(')"/><!-- remove the parenthetical comment ->
          </extensionValue>
          <extensionAuthorityUsed>
            <xsl:value-of select="substring-before(substring-after(., '('), ')')"/><!-- take what is inside the parenthesis ->
          </extensionAuthorityUsed>
        </extensionWrap>
      </pbcoreExtension>
    </xsl:if>
  </xsl:template>
  -->
</xsl:stylesheet>
