<cfparam name="context.ID" type="numeric">

<cfset thisProject = entityLoadByPK("project", context.ID)>

<cfoutput>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.project|update">
		<input name="projectID" type="hidden" value="#thisProject.getID()#">
		<input name="projectName" type="text" value="#thisProject.getName()#">
		<br>
		<input name="projectPath" type="text" value="#thisProject.getPath()#">
		<br>
		<input type="submit" value="Update Project">
	</cfform>
	<br>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.module|insert">
		<input name="projectID" type="hidden" value="#thisProject.getID()#">
		<input name="name" type="text" value="name">
		<br>
		<input type="submit" value="Add Module">
	</cfform>
</cfoutput>
