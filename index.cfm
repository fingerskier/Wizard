<cfset projects = entityload("project")>

<cf_page>
	<cfoutput>
		Projects
		<br>
		<br>
		<cfloop array="#projects#" index="project">
			<a class="projectLink" href="project.cfm?projectID=#project.getID()#">#project.getName()#</a>
			<div class="project"></div>
			<br>
		</cfloop>
		<br>
		<a class="projectLink" href="project.cfm?projectID=-7">New Project</a>
		<div class="project"></div>
	</cfoutput>
</cf_page>
