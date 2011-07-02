<cfcomponent>
	<cffunction access="remote" name="deploy">
		<cfargument name="projectID" required="true" type="numeric">

		<cfif arguments.projectID>

		</cfif>
	</cffunction>

	<cffunction access="remote" name="insert" returntype="Numeric">
  		<cfargument name="name" default="" type="string">
		<cfargument name="path" default="" type="string">

  		<cfset var project = "">

		<cfset project = entityNew("project")>
  		<cfset project.setName(arguments.name)>
 		<cfset project.setPath(arguments.path)>

		<cfset entitySave(project)>

		<cfreturn project.getID()>
	</cffunction>

	<cffunction access="remote" name="update" returntype="void">
		<cfargument name="projectID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">
		<cfargument name="path" required="true" type="string">

		<cfif len(arguments.name) and len(arguments.path)>
	  		<cfset var project = "">

			<cfset project = entityLoadByPK("project", arguments.projectID)>
   			<cfset project.setName(arguments.name)>
	  		<cfset project.setPath(arguments.path)>

			<cfset entitySave(project)>
		</cfif>
	</cffunction>
</cfcomponent>
