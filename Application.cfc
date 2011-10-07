<cfcomponent extends="framework" output="false">
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

	<cffunction name="setupApplication">

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

	<cffunction name="onError" access="public" returntype="void" output="true">
		<cfargument name="exception" type="any" required="true">
		<cfargument name="eventName" type="string" required="false" default="">

  		<cfparam name="application.errorLog" default="#arrayNew(1)#" type="array">

		<cfset arrayAppend(application.errorLog, arguments)>

		<div style="border: thin solid red;">
			<cfdump var="#arguments#">
		</div>
	</cffunction>
</cfcomponent>
