<cfajaximport tags="CFFORM">

<cfparam name="context.projectID" min="1" type="numeric">
<cfparam name="context.moduleID" type="numeric">

<cfif isDefined('context.save')>
	<cfif context.projectID lt 0>
		<cfset context.moduleID = application.action.module.insert(argumentCollection=context)>
 	<cfelse>
		<cfset application.action.module.update(argumentCollection=context)>
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
		<context method="post">
			<input name="projectID" type="hidden" value="#projectID#">
			<input name="moduleID" type="hidden" value="#moduleID#">

			<label for="moduleName">Module:</label>
			<input id="moduleName" name="name" type="text" value="#context.module.getName()#">
			<br>
			<input name="save" type="submit" value="Save Changes">
		</context>
		<br>
		<cfloop array="#tags#" index="tag">
			<cfdiv bind="url:tag.cfm?moduleID=#context.moduleID#&tagID=#tag.getID()#" class="tagAttributes" tagname="div" />
			<br>
		</cfloop>
	</cfoutput>
</cf_page>
