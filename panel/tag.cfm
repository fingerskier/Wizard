<cfset thisTag = entityLoadByPK("tag", context.ID)>
<cfset attrs = entityload("attr", {tag=thisTag})>

<cfif 'set,if,else,elseif' contains thisTag.getName()>
	<cfset attributedTag = false>
<cfelse>
	<cfset attributedTag = true>
</cfif>

<cfoutput>
	<cfform action="action/tag.cfc?method=update" method="post">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input name="name" type="text" value="#thisTag.getName()#">
		<input type="submit" value="Update Tag">
	</cfform>
	<cfform action="action/tag.cfc?method=addChild" method="post">
		<input name="moduleID" type="hidden" value="#thisTag.getModule().getID()#">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input name="name" type="text" value="tag">
		<input type="submit" value="Add Child">
	</cfform>
	<cfform action="action/tag.cfc?method=addSibling" method="post">
		<input name="moduleID" type="hidden" value="#thisTag.getModule().getID()#">
		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input name="parent" type="hidden" value="#thisTag.getParent()#">
		<input name="name" type="text" value="tag">
		<input type="submit" value="Add Sibling">
	</cfform>
	<cfform action="action/tag.cfc?method=moveUp" method="post">
 		<input name="tagID" type="hidden" value="#thisTag.getID()#">
		<input type="submit" value="Move Up">
	</cfform>
	<cfform action="action/tag.cfc?method=moveDown" method="post">
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
		<cfform action="action/attr.cfc?method=setAttr" method="post">
			<input name="tagID" type="hidden" value="#thisTag.getID()#">
			<input name="name" type="text" value="new">
			<input name="value" type="text" value="attribute">
			<input type="submit" value="save">
		</cfform>
	<cfelse>
	</cfif>
</cfoutput>
