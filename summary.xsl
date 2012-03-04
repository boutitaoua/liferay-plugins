<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet
	version="2.0"
	xmlns:str="http://xsltsl.org/string"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
	<xsl:import href="http://xsltsl.sourceforge.net/modules/stdlib.xsl" />

	<xsl:template match="/">
		<html>
			<head>
				<script src="http://yui.yahooapis.com/3.4.1/build/yui/yui-min.js" type="text/javascript"></script>
				<script type="text/javascript">
					YUI().use(
						'datatable',
						function (Y) {
							var pluginsCols = [
								{
									key: 'Artifact ID',
									sortable: true
								},
								{
									key: 'Name',
									sortable: true
								},
								{
									key: 'Type',
									sortable: true
								},
								{
									key: 'Tags',
									sortable: true
								},
								{
									key: 'Short Description',
									sortable: true
								},
								{
									key: 'Change Log',
									sortable: true
								},
								{
									key: 'Page URL',
									sortable: true
								},
								{
									key: 'Author',
									sortable: true
								},
								{
									key: 'Licenses',
									sortable: true
								},
								{
									key: 'Include in Bundle',
									sortable: true
								},
								{
									key: 'Experimental',
									sortable: true
								},
								{
									key: 'Marketplace',
									sortable: true
								},
								{
									key: 'Parent App',
									sortable: true
								},
								{
									key: 'Standalone App',
									sortable: true
								},
								{
									key: 'Supported',
									sortable: true
								}
							];

							var pluginsData = [
								<xsl:apply-templates select="plugins-summary/plugin" />
							];

							var pluginsDataTable = new Y.DataTable.Base(
								{
									columnset: pluginsCols,
									recordset: pluginsData,
									plugins: [Y.Plugin.DataTableSort]
								}
							);

							pluginsDataTable.render("#plugins");

							var authorsCols = [
								{
									key: 'Unique Authors',
									sortable: true
								}
							];

							var authorsData = [
								<xsl:apply-templates select="plugins-summary/author" />
							];

							var authorsDataTable = new Y.DataTable.Base(
								{
									columnset: authorsCols,
									recordset: authorsData,
									authors: [Y.Plugin.DataTableSort]
								}
							);

							authorsDataTable.render("#authors");

							var licensesCols = [
								{
									key: 'Unique Licenses',
									sortable: true
								}
							];

							var licensesData = [
								<xsl:apply-templates select="plugins-summary/license" />
							];

							var licensesDataTable = new Y.DataTable.Base(
								{
									columnset: licensesCols,
									recordset: licensesData,
									licenses: [Y.Plugin.DataTableSort]
								}
							);

							licensesDataTable.render("#licenses");
						}
					);
				</script>
			</head>

			<body class="yui3-skin-sam">
				<div id="plugins"></div>

				<br />

				<div id="authors"></div>

				<br />

				<div id="licenses"></div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="author">
		{
			'Unique Authors': '<xsl:value-of select="current()" />'
		}

		<xsl:if test="position() != last()">
			,
		</xsl:if>
	</xsl:template>

	<xsl:template match="license">
		{
			'Unique Licenses': '<xsl:value-of select="current()" />'
		}

		<xsl:if test="position() != last()">
			,
		</xsl:if>
	</xsl:template>

	<xsl:template match="plugin">
		{
			'Artifact ID': '<xsl:value-of select="artifact-id" />',
			'Name': '<xsl:value-of select="name" />',
			'Type': '<xsl:value-of select="type" />',
			'Tags': '<xsl:value-of select="tags" />',

			'Short Description':
				'<xsl:call-template name="str:subst">
					<xsl:with-param name="text" select="normalize-space(short-description) "/>
					<xsl:with-param name="replace">'</xsl:with-param>
					<xsl:with-param name="with">\'</xsl:with-param>
				</xsl:call-template>',

			'Change Log': '<xsl:value-of select="change-log" />',
			'Page URL': '<xsl:value-of select="page-url" />',
			'Author': '<xsl:value-of select="author" />',
			'Licenses': '<xsl:value-of select="licenses" />',

			<xsl:apply-templates select="releng" />
		}

		<xsl:if test="position() != last()">
			,
		</xsl:if>
	</xsl:template>

	<xsl:template match="releng">
		'Include in Bundle':
			'<xsl:choose>
				<xsl:when test="bundle = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>',

		'Experimental':
			'<xsl:choose>
				<xsl:when test="experimental = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>',

		'Marketplace':
			'<xsl:choose>
				<xsl:when test="marketplace = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>',

		'Parent App':
			'<xsl:choose>
				<xsl:when test="parent-app = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>',

		'Standalone App':
			'<xsl:choose>
				<xsl:when test="standalone-app = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>',

		'Supported':
			'<xsl:choose>
				<xsl:when test="supported = 'true'">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>'

		<xsl:if test="position() != last()">
			,
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>