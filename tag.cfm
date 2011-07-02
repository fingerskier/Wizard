<cfparam name="context.moduleID" min="1" type="numeric">
<cfparam name="context.tagID" type="numeric">
<cfparam name="context.showAttr" default="false" type="boolean">

<cfif isDefined('context.save')>
	<cfinvoke component="action.tag" method="upsert" moduleID="#context.moduleID#" tagID="#context.tagID#" name="#context.name#" returnvariable="context.tagID">
	<cflocation addtoken="false" url="tag.cfm?moduleID=#context.moduleID#&tagID=#context.tagID#">
<cfelseif isDefined('context.addAttr')>
<cfelseif isDefined('context.updateAttr')>
</cfif>

<cfset thisModule = entityload("module")>

<cfif context.tagID gt 0>
	<cfset context.tag = entityLoadByPK("tag", context.tagID)>
<cfelseif context.tagID lt 0>
	<cfset context.tag = entityNew("tag")>
	<cfset context.tag.setModule(thisModule)>
	<cfset entitySave(context.tag)>
	<cflocation url="tag.cfm?moduleID=#context.moduleID#&tagID=#context.tag.getID()#">
</cfif>

<cfset attrs = entityload('attr', {tag = context.tag})>

<div class="tagContainer">
	<cfoutput>
		<cfform method="post">
	 		<input name="name" type="text" value="#context.tag.getName()#">
			<input name="moduleID" type="hidden" value="#context.moduleID#">
			<input name="tagID" type="hidden" value="#context.tag.getID()#">
			<input name="save" type="submit">
		</cfform>

		<cfform method="post">
			<input name="moduleID" type="hidden" value="#context.moduleID#">
			<input name="tagID" type="hidden" value="#context.tag.getID()#">
			<cfif context.showAttr>
				<input name="showAttr" type="hidden" value="false">
				<input name="show" type="submit" value="hide attributes">
			<cfelse>
				<input name="showAttr" type="hidden" value="true">
				<input name="show" type="submit" value="show attributes">
			</cfif>
		</cfform>

		<cfif context.showAttr>
			<br>
			<cfloop array="#attrs#" index="attr">
				<cfform method="post">
					<input name="tagID" type="hidden" value="#context.tag.getID()#">
					<input name="attrID" type="hidden" value="#attr.getID()#">

					<input name="name" type="text" value="#attr.getName()#">
					<input name="value" type="text" value="#attr.getValue()#">
					<input name="updateAttr" type="submit" value="save">
				</cfform>
			</cfloop>
			<br>
			Add New:
			<br>
			<cfform method="post">
				<input name="tagID" type="hidden" value="#context.tagID#">
				<input name="attrID" type="hidden" value="-7">

				<input name="name" type="text" value="">
				<input name="value" type="text" value="">
				<input name="addAttr" type="submit" value="save">
			</cfform>
		</cfif>
	</cfoutput>
</div>
