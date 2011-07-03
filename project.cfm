<cfparam name="context.projectID" type="numeric">
<cfparam name="context.name" default="" type="string">
<cfparam name="context.path" default="" type="string">

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

<cfif context.projectID gt 0>
	<cfset context.project = entityLoadByPK("project", context.projectID)>
<cfelseif context.projectID lt 0>
	<cfset context.project = entityNew('project')>
	<cfset entitySave(context.project)>
</cfif>

<cfset modules = entityload("module", {project = context.project})>

<cfset projectName = context.project.getName()>
<cfif not len(projectName)>
	<cfset projectName = 'New'>
</cfif>

<cf_page>
	<cfoutput>
 		<div class="ui-widget">
			<h3 class="ui-widget-header"><a href="#application.URL#">Projects</a></h3>
			<div class="ui-widget-content">
				<cfform action="#CGI.SCRIPT_NAME#" method="post">
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
				<cfform class="deploy" method="post">
					<input name="projectID" type="hidden" value="#context.projectID#">
					<input name="moduleID" type="hidden" value="-7">
					<input type="submit" value="Add Module">
				</cfform>
			</div>
			<div class="ui-widget-content">
				<cfloop array="#modules#" index="module">
					<a href="module.cfm?projectID=#context.projectID#&moduleID=#module.getID()#">#module.getName()#</a>
					<br>
				</cfloop>
			</div>
 		</div>
	</cfoutput>
</cf_page>
