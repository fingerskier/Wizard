<cfparam name="context.moduleID" min="1" type="numeric">
<cfparam name="context.tagID" type="numeric">
<cfparam name="context.showAttr" default="false" type="boolean">

<cfif isDefined('context.save')>
	<cfinvoke component="action.tag" method="update" moduleID="#context.moduleID#" tagID="#context.tagID#" name="#context.name#">
<cfelseif isDefined('context.setAttr')>
	<cfinvoke component="action.attr" method="setAttr" tagID="#context.tagID#" name="#context.name#" value="#context.value#">
</cfif>

<cfset thisModule = entityload("module")>

<cfif context.tagID gt 0>
	<cfset context.tag = entityLoadByPK("tag", context.tagID)>
<cfelseif context.tagID lt 0>
	<cfset context.tag = entityNew("tag")>
	<cfset context.tag.setModule(thisModule)>
	<cfset entitySave(context.tag)>
</cfif>

<cfset attrs = entityload('attr', {tag = context.tag})>

<div class="ui-widget tagContainer">
	<cfoutput>
		<cfform method="post">
			<input name="moduleID" type="hidden" value="#context.tag.getModule().getID()#">
			<input name="tagID" type="hidden" value="#context.tag.getID()#">
	 		<input name="name" type="text" value="#context.tag.getName()#">
			<input name="save" type="submit" value="save">
		</cfform>

		<cfform method="post">
			<input name="moduleID" type="hidden" value="#context.tag.getModule().getID()#">
			<input name="tagID" type="hidden" value="#context.tag.getID()#">
			<input name="lineNum" type="hidden" value="#context.tag.getLineNum()#">
			<input name="addChild" type="submit" value="add child">
		</cfform>

		<cfform method="post">
			<input name="moduleID" type="hidden" value="#context.tag.getModule().getID()#">
			<input name="tagID" type="hidden" value="#context.tag.getID()#">
			<input name="parent" type="hidden" value="#context.tag.getParent()#">
			<input name="lineNum" type="hidden" value="#context.tag.getLineNum()#">
			<input name="addSibling" type="submit" value="add sibling">
		</cfform>

		<cfform method="post">
			<input name="moduleID" type="hidden" value="#context.tag.getModule().getID()#">
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
