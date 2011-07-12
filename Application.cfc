<cfcomponent output="false">
	<cfset this.name = "Wizard">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<cfset this.applicationTimeout = createTimeSpan(0,1,0,0)>
	<cfset this.clientStorage = 'database'>
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

	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">
 		<cfset application.URL = 'http://' & CGI.HTTP_HOST & '/Wizard/'>
		<cfset application.path = getDirectoryFromPath(getBaseTemplatePath())>

  		<cfset application.action = structNew()>
		<cfset application.action.module = createObject("component", 'action.module')>
		<cfset application.action.project = createObject("component", 'action.project')>
		<cfset application.action.tag = createObject("component", 'action.tag')>

  		<cfset application.errorLog = arrayNew(1)>
  		<cfset application.debugLog = arrayNew(1)>

		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" access="public" returntype="void" output="false">
		<cfargument name="applicationScope" type="struct" required="false" default="#structNew()#">

		<cfreturn true>
	</cffunction>

	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
	</cffunction>

	<cffunction name="onSessionEnd" access="public" returntype="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="applicationScope" type="struct" required="false" default="#StructNew()#">

	</cffunction>

	<cffunction name="onRequestStart" access="public" returnType="boolean" output="false">
	    <cfargument type="String" name="targetPage" required="true">

		<cfif isDefined('URL.restart') and (URL.restart is 'goober')>
			<cfset ormReload()>
			<cfset applicationStop()>
		</cfif>

  		<cfset request.context = structCopy(form)>
		<cfset structAppend(request.context, URL)>


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

	    <cfreturn true>
	</cffunction>

	<cffunction name="onRequest" access="public" returntype="void" output="true">
		<cfargument name="targetPage" type="string" required="true"/>

		<cfset var context = request.context>

		<cfinclude template="#arguments.TargetPage#">
	</cffunction>

	<cffunction name="onRequestEnd" access="public" returntype="void" output="true">
 		<cfif isDefined('context.wizard_action')>
   			<cfinclude template="#CGI.HTTP_REFERER#">
		</cfif>
	</cffunction>

	<cffunction name="onError" access="public" returntype="void" output="true">
		<cfargument name="exception" type="any" required="true">
		<cfargument name="eventName" type="string" required="false" default="">

  		<cfparam name="application.errorLog" default="#arrayNew(1)#" type="array">

		<cfset arrayAppend(application.errorLog, arguments)>

		<div style="border: thin solid red;">
			<cfdump var="#arguments#">
		</div>
	</cffunction>

	<cffunction name="onMissingTemplate" access="public" returnType="boolean" output="false">
   		<cfargument type="string" name="targetPage" required=true>

		<cfreturn true>
	</cffunction>
</cfcomponent>

