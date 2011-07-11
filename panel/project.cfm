<cfparam name="context.ID" type="numeric">

<cfset thisProject = entityLoadByPK("project", context.ID)>

<cfoutput>
	<cfform action="action/project.cfc?method=update">
		<input name="projectID" type="hidden" value="#thisProject.getID()#">
		<input name="name" type="text" value="#thisProject.getName()#">
		<br>
		<input name="path" type="text" value="#thisProject.getPath()#">
		<br>
		<input type="submit" value="Update Project">
	</cfform>
	<br>
	<cfform action="action/module.cfc?method=insert" method="post">
		<input name="projectID" type="hidden" value="#thisProject.getID()#">
		<input name="name" type="text" value="name">
		<br>
		<input type="submit" value="Add Module">
	</cfform>
</cfoutput>
