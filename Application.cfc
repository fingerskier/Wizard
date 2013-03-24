<cfcomponent extends="framework" output="false">
<!---
	<cfset this.clientManagement = true>
	<cfset this.clientStorage = 'database'>
	<cfset this.name = "Wizard">
--->
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<cfset this.applicationTimeout = createTimeSpan(0,1,0,0)>
	<cfset this.debugipaddress = '127.0.0.1'>
 	<cfset this.customTagPaths = expandPath('./tags')>

	<cfset this.datasource = 'Wiz'>
	<cfset this.ormenabled = true>
	<cfset this.ormsettings = {
		cfclocation = "model",
		dbcreate = "dropcreate",
		dialect = "Derby",
		eventHandling = true
	}>

	<cfset variables.framework.action = 'action'>
	<cfset variables.framework.usingSubsystems = false>
	<cfset variables.framework.defaultSection = 'main'>
	<cfset variables.framework.defaultItem = 'default'>
	<cfset variables.framework.home = 'main.default'>
	<cfset variables.framework.error = 'main.error'>
	<cfset variables.framework.reload = 'goober'>
	<cfset variables.framework.password = 'fishes'>
	<cfset variables.framework.reloadApplicationOnEveryRequest = false>
	<cfset variables.framework.generateSES = false>
	<cfset variables.framework.SESOmitIndex = false>
	<cfset variables.framework.baseURL = 'useCgiScriptName'>
	<cfset variables.framework.suppressImplicitService = true>
	<cfset variables.framework.unhandledExtensions = 'cfc'>
	<cfset variables.framework.unhandledPaths = '/tests,/tags'>
	<cfset variables.framework.preserveKeyURLKey = 'fw1pk'>
	<cfset variables.framework.maxNumContextsPreserved = 10>
	<cfset variables.framework.cacheFileExists = false>
	<cfset variables.framework.applicationKey = 'com.fingerskier.wizard'>

	<cffunction name="ajaxURL" returntype="String">
		<cfargument name="action" type="string" />
		<cfargument name="container" type="string" />
		<cfargument name="path" type="string" default="#variables.framework.baseURL#" />
		<cfargument name="queryString" type="string" default="" />

		<cfset var result = "javascript:ColdFusion.navigate(">
  		<cfset result &= "'" & buildURL(arguments.action, "", arguments.queryString) & "'">
  		<cfset result &= ", '" & arguments.container & "'">
		<cfset result &= ")">

		<cfreturn result>
	</cffunction>

	<cffunction name="onError">
		<cfargument name="exception">
		<cfargument name="event">

		<cfparam name="application.errorLog" default="#arrayNew(1)#">

  		<cfset var thisError = structCopy(arguments)>
		<cfset thisError.detail = structGetValue(arguments, "Detail")>
  		<cfset thisError.detail = structGetValue(thisError, "Detail")>
		<cfset thisError.message = structGetValue(thisError, "Message")>
		<cfset thisError.resolvedName = structGetValue(thisError, "ResolvedName")>
		<cfset thisError.type = structGetValue(thisError, "Type")>
		<cfset thisError.element = structGetValue(thisError, "Element")>
		<cfset thisError.name = structGetValue(thisError, "Name")>
		<cfset thisError.SQL = structGetValue(thisError, "sql")>
		<cfset thisError.tagContext = structGetValue(thisError, "TagContext")>

		<div style="border: thin solid red;">
			An error has occurred.<br>The developer has been notified and will tend to it...
			<cfdump var="#thisError#" label="thisError">
   			<cfdump var="#arguments#" label="arguments scope">
		</div>

  		<cfset var error = structCopy(arguments)>

		<cfset arrayAppend(application.errorLog, error)>
	</cffunction>

	<cffunction name="setupApplication">
		<cfparam name="application.errorLog" default="#arrayNew(1)#">

   		<cftry>
	 		<cfset application.errorLog = objectload("errors.data")>

	 		<cfcatch type="any"></cfcatch>
	 	</cftry>
	</cffunction>

	<cffunction name="setupRequest">
  		<cfif isDefined('request.context.name')>
			<cfset var newWord = entityNew('term')>
   			<cfset newWord.setText(request.context.name)>
	  		<cfset entitySave(newWord)>
		</cfif>

		<cfif isDefined('request.context.wizard_action')>
  			<cfset var wizard_cfc = listFirst(request.context.wizard_action, '|')>
  			<cfset var wizard_method = listLast(request.context.wizard_action, '|')>
	 		<cfset structDelete(request.context, 'wizard_cfc')>
	 		<cfset structDelete(request.context, 'wizard_method')>
	 		<cfinvoke component="#wizard_cfc#" method="#wizard_method#" argumentcollection="#request.context#">
		</cfif>
	</cffunction>

	<cffunction name="setupSession">
	</cffunction>

	<cffunction name="structGetValue" returntype="any">
		<cfargument name="S" required="true" type="struct">
		<cfargument name="key" required="true" type="string">

		<cfset var thisn = structFindKey(arguments.S, arguments.key)>

		<cfif arraylen(thisn)>
			<cfreturn thisn[1]['value']>
		<cfelse>
  			<cfreturn "">
		</cfif>
	</cffunction>
</cfcomponent>
