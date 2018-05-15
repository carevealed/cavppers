<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:p="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:str="http://exslt.org/strings" version="1.0" extension-element-prefixes="xsi str p">
  <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="p:instantiationLocation">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
    <xsl:for-each select="str:tokenize($instantiationpart,'+')">
      <instantiationPart>
        <xsl:copy-of select="document(normalize-space(.))/p:pbcoreInstantiationDocument/node()"/>
      </instantiationPart>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>