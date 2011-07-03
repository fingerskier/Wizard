<cfajaximport tags="CFFORM">

<cfparam name="context.projectID" min="1" type="numeric">
<cfparam name="context.moduleID" type="numeric">

<cfif isDefined('context.save')>
	<cfif context.moduleID lt 0>
 		<cfinvoke component="action.module" method="insert" projectID="#context.projectID#" name="#context.name#" returnvariable="context.moduleID">
 	<cfelse>
  		<cfinvoke component="action.module" method="update" projectID="#context.projectID#" moduleID="#context.moduleID#" name="#context.name#">
	</cfif>
	<cflocation addtoken="false" url="module.cfm?projectID=#context.projectID#&moduleID=#context.moduleID#">
</cfif>

<cfset context.project = entityLoadByPK("project", context.projectID)>

<cfif context.moduleID gt 0>
	<cfset context.module = entityLoadByPK("module", context.moduleID)>
<cfelseif moduleID lt 0>
	<cfset context.module = entityNew("module")>
	<cfset context.module.setProject(context.project)>
	<cfset entitySave(context.module)>
</cfif>

<cfset tags = entityLoad("tag", {module = context.module})>

<cfif not arraylen(tags)>
	<cfset moduleExtension = listLast(context.module.getName(), '.')>
	<cfset wrapperTag = entityNew("tag")>
	<cfset wrapperTag.setModule(context.module)>

	<cfif moduleExtension is 'cfm'>
 		<cfset wrapperTag.setName('html')>
	<cfelseif moduleExtension is 'cfc'>
 		<cfset wrapperTag.setName('component')>
	<cfelse>
 		<cfset wrapperTag.setName('wrapper')>
	</cfif>
	<cfset entitySave(wrapperTag)>

	<cfset arrayPrepend(tags, wrapperTag)>
</cfif>

<cfset moduleName = context.module.getName()>
<cfif not len(moduleName)>
	<cfset moduleName = 'new_module'>
</cfif>

<cf_page>
	<cfoutput>
 		<iddiv class="ui-widget">
			<h3 class="ui-widget-header"><a href="#application.URL#">Projects</a>/<a href="#application.URL#project.cfm?projectID=#context.project.getID()#">#context.project.getName()#</a></h3>
			<div class="ui-widget-content">
				<form method="post">
					<input name="projectID" type="hidden" value="#projectID#">
					<input name="moduleID" type="hidden" value="#moduleID#">

					<label for="moduleName">Module:</label>
					<input id="moduleName" name="name" type="text" value="#context.module.getName()#">
					<br>
					<input name="save" type="submit" value="Save Changes">
				</form>
			</div>
			<div class="ui-widget-content">
				<cfloop array="#tags#" index="tag">
					<cfdiv bind="url:tag.cfm?moduleID=#context.moduleID#&tagID=#tag.getID()#" class="tagAttributes" tagname="div" />
					<br>
				</cfloop>
			</div>
 		</div>
	</cfoutput>
</cf_page>
