<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:p="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:str="http://exslt.org/strings" version="1.0" extension-element-prefixes="xsi str p">
  <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="/csv">
    <pbcoreInstantiationDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                      xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
                      xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html https://raw.githubusercontent.com/WGBH/PBCore_2.1/master/pbcore-2.1.xsd">
      <xsl:apply-templates select="row[starts-with(col2,$select)]"/>
    </pbcoreInstantiationDocument>
  </xsl:template>
  <xsl:template match="row">
    <xsl:apply-templates select="col2" mode="instantiation"/><!-- id -->
    <xsl:apply-templates select="XXX" mode="instantiation"/><!-- date -->
    <xsl:apply-templates select="col25"/><!-- physical -->
    <xsl:apply-templates select="col6"/><!-- location -->
    <xsl:apply-templates select="col8"/><!-- mediatype -->
    <xsl:apply-templates select="col9"/><!-- generations -->
    <xsl:apply-templates select="col29"/><!-- colors -->
    <xsl:apply-templates select="col28"/><!-- tracks -->
    <xsl:apply-templates select="col41"/><!-- langauge -->
    <xsl:apply-templates select="col26|col66"/><!-- annotations -->
  </xsl:template>
  
  <!-- PBCORE TEMPLATES -->
  <!-- Dates -->
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
  <xsl:template name="instantiation-annotation-extant" match="col26|col66">
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
  <!-- instantiation stuff -->
  <xsl:template name="inst-identifier-cavpp" match="col2" mode="instantiation">
    <xsl:if test="string-length(.)>0">
      <instantiationIdentifier>
        <xsl:variable name="column" select="count(preceding-sibling::*)+1"/>
        <xsl:attribute name="source">California Revealed</xsl:attribute>
        <xsl:attribute name="annotation">
          <xsl:value-of select="../../row[1]/*[$column]"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="string-length($part_id)>0">
            <xsl:value-of select="$part_id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
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

</xsl:stylesheet>
