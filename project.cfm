<cfparam name="context.projectID" type="numeric">
<cfparam name="context.name" default="" type="string">
<cfparam name="context.path" default="" type="string">

<cfif isDefined('context.delete')>
	<cfparam name="context.moduleID" type="numeric">
	<cfinvoke component="action.module" method="delete" moduleID="#context.moduleID#">
	<cflocation addtoken="false" url="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
</cfif>

<cfif isDefined('context.save')>
	<cfif context.projectID lt 0>
   		<cfinvoke component="action.project" method="insert" name="#context.name#" path="#context.path#" returnvariable="context.projectID">
	<cfelse>
   		<cfinvoke component="action.project" method="update" projectID="#context.projectID#" name="#context.name#" path="#context.path#">
	</cfif>
	<cflocation addtoken="false" url="project.cfm?projectID=#context.projectID#">
<cfelseif isDefined('context.deploy')>
	<cfset application.action.project.deploy(argumentCollection=context)>
</cfif>

<cfif context.projectID lt 0>
	<cfset context.project = entityNew('project')>
	<cfset entitySave(context.project)>
	<cflocation url="project.cfm?projectID=#context.project.getID()#">
</cfif>

<cfset context.project = entityLoadByPK("project", context.projectID)>

<cfset modules = entityload("module", {project = context.project})>

<cfset projectName = context.project.getName()>
<cfif not len(projectName)>
	<cfset projectName = 'New'>
</cfif>

<cf_page>
	<cfoutput>
 		<div class="ui-widget">
			<h3 class="ui-corner-all ui-widget-header"><a href="#application.URL#">Projects</a></h3>
			<div class="ui-corner-top ui-widget-content">
				<cfform method="post">
					<input name="projectID" type="hidden" value="#context.projectID#">
					<label for="projectName">Project:</label>
					<input id="projectName" name="name" type="text" value="#context.project.getName()#">
					<br>
					<label for="projectPath">Path:</label>
					<input id="projectPath" name="path" type="text" value="#context.project.getPath()#">
					<br>
					<input name="save" type="submit" value="Save Changes">
				</cfform>
				<cfform class="deploy" method="post">
					<input name="projectID" type="hidden" value="#context.projectID#">
					<input name="deploy" type="submit" value="Deploy Changes">
				</cfform>
				<cfform action="module.cfm" class="deploy" method="post">
					<input name="projectID" type="hidden" value="#context.projectID#">
					<input name="moduleID" type="hidden" value="-7">
					<input type="submit" value="Add Module">
				</cfform>
			</div>
			<div class="ui-corner-bottom ui-widget-content">
				<cfloop array="#modules#" index="module">
					<cfform method="post">
	 					<input name="moduleID" type="hidden" value="#module.getID()#">
						<a href="module.cfm?projectID=#context.projectID#&moduleID=#module.getID()#">#module.getName()#</a>
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
