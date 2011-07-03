<cfcomponent>
	<cffunction access="remote" name="insert" returntype="Numeric">
		<cfargument name="projectID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfset var result = 0>

		<cfif len(arguments.name)>
			<cfset var module = "">
	  		<cfset var project = entityLoadByPK("project", arguments.projectID)>

   			<cfset module = entityNew("module")>
	  		<cfset module.setProject(project)>
	  		<cfset module.setName(arguments.name)>

			<cfset entitySave(module)>
   			<cfset result = module.getID()>
		</cfif>

		<cfreturn result>
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
