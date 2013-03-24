<cfdump var="#rc#">

<cfform name="projectEdit">
	<label for="projectName">Name</label>
	<cfinput id="projectName" maxlength="255" name="name" required="true" value="#rc.project.getName()#">

	<label for="projectPath">Path</label>
	<cfinput id="projectPath" maxlength="255" name="path" required="true" value="#rc.project.getPath()#">
</cfform>