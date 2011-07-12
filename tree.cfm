<cfajaximport tags="CFFORM,CFINPUT-AUTOSUGGEST">

<cf_page>
	<table>
		<tr>
			<td valign="top">
				<cfform>
					<cftree cache="false" format="html" name="tags">
						<cftreeitem bind="cfc:tree.getNodes({cftreeitemvalue},{cftreeitempath})">
					</cftree>
				</cfform>
			</td>

			<td valign="top">
				<cfdiv bind="url:controlPanel.cfm?node={tags.node}&path={tags.path}" />
			</td>
		</tr>
	</table>
</cf_page>
