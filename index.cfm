<cfif isDefined('context.delete')>
	<cfparam name="context.projectID" type="numeric">

	<cfset thisn = entityLoadByPK("project", context.projectID)>
	<cfset entityDelete(thisn)>
</cfif>

<cfset projects = entityload("project")>

<cf_page>
	<cfoutput>
 		<div class="ui-widget">
			<h3 class="ui-widget-header">Projects</h3>
			<div class="ui-widget-content">
				<a class="projectLink" href="project.cfm?projectID=-7">New Project</a>
			</div>
			<div class="ui-widget-content">
				<cfloop array="#projects#" index="project">
					<cfform>
	 					<input name="projectID" type="hidden" value="#project.getID()#">
						<a class="projectLink" href="project.cfm?projectID=#project.getID()#">#project.getName()#</a>
						<button class="ui-state-default ui-corner-all" name="delete" type="submit">
							<span class="ui-icon ui-icon-circle-close"></span>
						</button>
					</cfform>
					<br>
				</cfloop>
			</div>
 		</div>
	</cfoutput>
</cf_page>
