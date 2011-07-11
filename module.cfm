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

<cfif isDefined('context.saveTag') or isDefined('context.addChild') or isDefined('context.addSibling') or isDefined('context.deleteTag')>
	<cfparam name="context.tagID" type="numeric">

	<cfif isDefined('context.saveTag')>
		<cfinvoke component="action.tag" method="update" moduleID="#context.moduleID#" tagID="#context.tagID#" name="#context.name#">
 	<cfelseif isDefined('context.deleteTag')>
  		<cfinvoke component="action.tag" method="delete" tagID="#context.tagID#">
 	<cfelseif isDefined('context.addChild')>
  		<cfinvoke component="action.tag" method="addChild" tagID="#context.tagID#">
	<cfelseif isDefined('context.addSibling')>
 		<cfparam name="context.parent" type="numeric">
   		<cfinvoke component="action.tag" method="addSibling" moduleID="#context.moduleID#" tagID="#context.tagID#" parent="#context.parent#">
	</cfif>
</cfif>

<cfset context.project = entityLoadByPK("project", context.projectID)>

<cfif moduleID lt 0>
	<cfset context.module = entityNew("module")>
	<cfset context.module.setProject(context.project)>
	<cfset entitySave(context.module)>
	<cflocation addtoken="false" url="module.cfm?projectID=#context.project.getID()#&moduleID=#context.module.getID()#">
</cfif>

<cfset context.module = entityLoadByPK("module", context.moduleID)>

<cfset tags = entityLoad("tag", {module = context.module, parent = 0})>

<cfif not arraylen(tags)>
	<cfset moduleExtension = listLast(context.module.getName(), '.')>
	<cfset wrapperTag = entityNew("tag")>
	<cfset wrapperTag.setModule(context.module)>
	<cfset wrapperTag.setParent(0)>

	<cfif moduleExtension is 'cfm'>
 		<cfset wrapperTag.setName('html')>
	<cfelseif moduleExtension is 'cfc'>
 		<cfset wrapperTag.setName('component')>
	<cfelse>
 		<cfset wrapperTag.setName('wrapper')>
	</cfif>

	<cfset entitySave(wrapperTag)>

	<cflocation addtoken="false" url="module.cfm?projectID=#context.project.getID()#&moduleID=#context.module.getID()#">
</cfif>

<cfset moduleName = context.module.getName()>
<cfif not len(moduleName)>
	<cfset moduleName = 'new_module'>
</cfif>

<cf_page>
	<cfoutput>
 		<div class="ui-widget">
			<h3 class="ui-corner-all ui-widget-header"><a href="#application.URL#">Projects</a>/<a href="#application.URL#project.cfm?projectID=#context.project.getID()#">#context.project.getName()#</a></h3>
			<div class="ui-corner-top ui-widget-content">
				<form method="post">
					<input name="projectID" type="hidden" value="#projectID#">
					<input name="moduleID" type="hidden" value="#moduleID#">

					<label for="moduleName">Module:</label>
					<input id="moduleName" name="name" type="text" value="#context.module.getName()#">
					<br>
					<input name="save" type="submit" value="save">
				</form>
			</div>
			<div class="ui-corner-bottom ui-widget-content">
				#showTags(context.module, 0)#
			</div>
 		</div>
	</cfoutput>
</cf_page>

<cffunction name="showTags" output="true">
	<cfargument name="module" required="true" type="model.module">
	<cfargument name="parentID" required="true" type="numeric">

	<cfset var tags = entityload("tag", {module = arguments.module, parent = arguments.parentID})>

	<cfif arraylen(tags)>
		<cfoutput>
			<ul>
				<cfloop array="#tags#" index="tag">
					<li>
						<cfdiv bind="url:tag.cfm?moduleID=#arguments.module.getID()#&tagID=#tag.getID()#" />

						#showTags(arguments.module, tag.getID())#
					</li>
				</cfloop>
			</ul>
		</cfoutput>
	</cfif>
</cffunction>
