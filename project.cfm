<cfparam name="projectID" type="numeric">

<cfif projectID gt 0>
	<cfset thisProject = entityLoadByPK("project", projectID)>
<cfelseif projectID lt 0>
	<cfset thisProject = entityNew('project')>
</cfif>

<cfset modules = entityload("module", {project = thisProject})>

<cfset projectName = thisProject.getName()>
<cfif not len(projectName)>
	<cfset projectName = 'New'>
</cfif>

<cfoutput>
	<form action="action/project.cfc?method=upsert" method="post">
		<input name="projectID" type="hidden" value="#projectID#">
		<label for="projectName">Project:</label>
		<input id="projectName" name="name" type="text" value="#thisProject.getName()#">
		<br>
		<label for="projectPath">Path:</label>
		<input id="projectPath" name="path" type="text" value="#thisProject.getPath()#">
		<br>
		<input type="submit" value="Save Changes">
	</form>
	<br>
	<cfloop array="#modules#" index="module">
		<a href="module.cfm?projectID=#projectID#&moduleID=#module.getID()#">#module.getName()#</a>
		<br>
	</cfloop>
	<br>
	<a href="module.cfm?projectID=#projectID#&moduleID=-7">Add Module</a>
</cfoutput>
