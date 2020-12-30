<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:slash="http://purl.org/rss/1.0/modules/slash/" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:feedstyle="https://www.howtogeek.com/ns/feedstyle" version="1.0">
<xsl:output method="html" encoding="utf-8"/>
<xsl:variable name="title" select="/rss/channel/title"/>
<xsl:variable name="feedUrl" select="/rss/channel/atom10:link[@rel='self']/@href" xmlns:atom10="http://www.w3.org/2005/Atom"/>
<xsl:variable name="link" select="/rss/channel/link"/>
<xsl:variable name="feedUrlEncoded" select="/rss/channel/encoded"/>

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
<xsl:element name="html">
<head>
	<title>Jeremy's Notes RSS Feed</title>
	<link href="https://jeremysnotes.com/lib/tpl/master/css/rss.css" rel="stylesheet" type="text/css" media="all"/>
	<link rel="alternate" type="application/rss+xml" title="{$title}" href="{$feedUrl}"/>
	<script><![CDATA[
function pop(url){
	var k=window.open(url,'','left='+(screen.width/2-400)+',top='+(screen.height/2-300)+',width=800,height=600,personalbar=0,toolbar=0,scrollbars=1,resizable=1');
	if(k===null||!k){
		alert('The share dialog was blocked by your popup blocker. Please disable your popup blocker.');
		return;
	}
	k.focus();
}
	]]></script>
</head>
<body>
	<div id="header">
		<h1 class="title"><a href="{normalize-space($link)}" title="Return to {$title}">Subscribe to Jeremy's Notes with RSS</a></h1>

		<div class="share">
			<xsl:for-each select="/rss/channel/feedstyle:reader">
				<a href="{@url}" target="_blank"><xsl:value-of select="@name"/></a>
			</xsl:for-each>
		</div>
	</div>
	<div id="main">

		<xsl:for-each select="/rss/channel/item">
			<xsl:variable name="item" select="."/>
			<div class="post">
				<h3 class="title"><a href="{normalize-space(link)}"><xsl:value-of select="title"/></a></h3>

				<div class="tagline">
					<xsl:if test="count(child::pubDate)=1">
						  <xsl:value-of select="normalize-space(substring(pubDate,5,string-length(pubDate)-10))"/>
					</xsl:if>
				</div>

				<div class="description">
					<xsl:value-of select="*[name()='description:encoded']" disable-output-escaping="yes"/>
				</div>

				<div class="share">
					<xsl:for-each select="/rss/channel/feedstyle:button">
						<a href="#" onclick="pop('{@url}'.replace('%url%', encodeURIComponent('{normalize-space($item/link)}')));return false"><xsl:value-of select="@name"/></a>
					</xsl:for-each>
				</div>
			</div>
		</xsl:for-each>
	</div>
	<div id="footer">
		 
	</div>
</body>
</xsl:element>
</xsl:template>
</xsl:stylesheet>
