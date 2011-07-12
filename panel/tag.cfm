<cfset thisTag = entityLoadByPK("tag", context.ID)>
<cfset attrs = entityload("attr", {tag=thisTag})>

<cfif 'set,if,else,elseif' contains thisTag.getName()>
	<cfset attributedTag = false>
<cfelse>
	<cfset attributedTag = true>
</cfif>

<cfoutput>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|update">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input name="name" type="text" value="#thisTag.getName()#">
		<input type="submit" value="Update Tag">
	</cfform>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|addChild">
		<input name="moduleID" type="hidden" value="#thisTag.getModule().getID()#">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<cfinput name="tagName" type="text" value="tag" autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
		<cfinput name="nameAttr" type="text" value="tag" autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
		<input type="submit" value="Add Child">
	</cfform>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|addSibling">
		<input name="moduleID" type="hidden" value="#thisTag.getModule().getID()#">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input name="parent" type="hidden" value="#thisTag.getParent()#">
		<cfinput name="tagName" type="text" value="tag" autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
		<cfinput name="nameAttr" type="text" value="tag" autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
		<input type="submit" value="Add Sibling">
	</cfform>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|moveUp">
 		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input type="submit" value="Move Up">
	</cfform>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|moveDown">
 		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input type="submit" value="Move Down">
	</cfform>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.tag|delete">
 		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input type="submit" value="Move Down">
	</cfform>
	<br>
	<cfif attributedTag>
		<table>
			<cfloop array="#attrs#" index="attr">
				<tr>
					<td align="right">#attr.getName()#</td>
					<td>=</td>
					<td align="left">#attr.getValue()#</td>
				</tr>
			</cfloop>
		</table>
		<br>
		<cfform method="post">
			<input name="wizard_action" type="hidden" value="action.attr|setAttr">
			<input name="tagID" type="hidden" value="#thisTag.getID()#">
			<cfinput name="name" type="text" value="new" autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
			<input name="value" type="text" value="attribute">
			<input type="submit" value="save">
		</cfform>
	<cfelse>
		<cfform method="post">
			<input name="wizard_action" type="hidden" value="action.attr|setAttr">
			<input name="tagID" type="hidden" value="#thisTag.getID()#">
			<cfinput name="name" type="hidden" value=" " autosuggest="cfc:wizard.action.tag.autosuggest({cfautosuggestvalue})" autosuggestbinddelay="1" autosuggestminlength="2" showautosuggestloadingicon="true" matchcontains="true">
			<input name="value" type="text" value="attribution">
			<input type="submit" value="save">
		</cfform>
	</cfif>
</cfoutput>
