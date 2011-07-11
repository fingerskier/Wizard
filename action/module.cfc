<cfcomponent>
	<cffunction access="remote" name="delete" returntype="void">
		<cfargument name="moduleID" required="true" type="numeric">

		<cfset var thisn = entityLoadByPK("module", arguments.moduleID)>
		<cfset entityDelete(thisn)>
	</cffunction>

	<cffunction access="remote" name="insert">
		<cfargument name="projectID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfif len(arguments.name)>
			<cfset var module = "">
	  		<cfset var project = entityLoadByPK("project", arguments.projectID)>

   			<cfset module = entityNew("module")>
	  		<cfset module.setProject(project)>
	  		<cfset module.setName(arguments.name)>

			<cfset entitySave(module)>

   			<cfset var newbie = entityNew("tag")>
	  		<cfset newbie.setModule(module)>
	 		<cfset newbie.setName('component')>
			<cfset entitySave(newbie)>
		</cfif>
	</cffunction>

	<cffunction access="remote" name="update" returntype="void">
		<cfargument name="moduleID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfif len(arguments.name)>
			<cfset var module = entityLoadByPK("module", arguments.moduleID)>

   			<cfset module.setName(arguments.name)>
			<cfset entitySave(module)>
		</cfif>
	</cffunction>
</cfcomponent>
