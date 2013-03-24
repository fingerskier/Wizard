<cfajaximport tags="cfform">

<!doctype html>
<html>
	<head>
		<title>ColdFusion Wizard</title>
	</head>

	<body>
		<cfoutput>
			<cflayout type="hbox">
				<cflayoutarea>
					<form>
						<ul>
							<cfloop array="#rc.projects#" index="project">
								<li>
									<input id="projectID#project.getID()#" name="projectID" type="radio" value="#project.getID()#">
									<label for="projectID#project.getID()#">#project.getName()#</label>
								</li>
							</cfloop>

							<li>
								<input id="newProjectID" name="projectID" type="radio" value="-7">
								<label for="newProjectID">Add Project</label>
							</li>
						</ul>
					</form>
				</cflayoutarea>

				<cflayoutarea source="#buildURL('project.edit')#&projectID={projectID}" />
			</cflayout>
		</cfoutput>
	</body>
</html>
