<!---<cfif isDefined('context.delete')>
	<cfparam name="context.projectID" type="numeric">
	<cfinvoke component="action.project" method="delete" projectID="#context.projectID#">
	<cflocation addtoken="false" url="#CGI.SCRIPT_NAME#">
</cfif>

<cfset projects = entityload("project")>

<cf_page>
	<cfoutput>
 		<div class="ui-widget">
			<h3 class="ui-corner-all ui-widget-header">Projects</h3>
			<div class="ui-corner-top ui-widget-content">
				<a class="projectLink" href="project.cfm?projectID=-7">New Project</a>
			</div>
			<div class="ui-corner-bottom ui-widget-content">
				<cfloop array="#projects#" index="project">
					<cfform method="post">
	 					<input name="projectID" type="hidden" value="#project.getID()#">
						<a class="projectLink" href="project.cfm?projectID=#project.getID()#">#project.getName()#</a>
						<button class="ui-state-error ui-corner-all" name="delete" type="submit">
							<span class="ui-icon ui-icon-circle-close"></span>
						</button>
					</cfform>
					<br>
				</cfloop>
			</div>
 		</div>
	</cfoutput>
</cf_page>
--->