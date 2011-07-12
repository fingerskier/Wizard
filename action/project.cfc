<cfcomponent>
	<cffunction access="remote" name="delete" returntype="void">
		<cfargument name="projectID" required="true" type="numeric">

		<cfset var thisn = entityLoad("project", arguments.projectID, true)>
		<cfset entityDelete(thisn)>
	</cffunction>

	<cffunction access="remote" name="deploy">
		<cfargument name="projectID" required="true" type="numeric">

		<cfif arguments.projectID>

		</cfif>
	</cffunction>

	<cffunction access="remote" name="insert" returntype="void">
  		<cfargument name="projectName" default="" type="string">
		<cfargument name="projectPath" default="" type="string">

  		<cfset var project = "">

		<cfset project = entityNew("project")>
  		<cfset project.setName(arguments.projectName)>
 		<cfset project.setPath(arguments.projectPath)>

		<cfset entitySave(project)>
	</cffunction>

	<cffunction access="remote" name="update" returntype="void">
		<cfargument name="projectID" required="true" type="numeric">
  		<cfargument name="projectName" required="true" type="string">
		<cfargument name="projectPath" required="true" type="string">

		<cfif len(arguments.projectName) and len(arguments.projectName)>
	  		<cfset var project = "">

			<cfset project = entityLoadByPK("project", arguments.projectID)>
   			<cfset project.setName(arguments.projectName)>
	  		<cfset project.setPath(arguments.projectPath)>

			<cfset entitySave(project)>
		</cfif>
	</cffunction>
</cfcomponent>
