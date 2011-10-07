component persistent="true" {
	property name="ID" fieldtype="id" generator="native" ormtype="integer" type="numeric";

	property name="tag" cfc="tag" fieldtype="many-to-one" fkcolumn="tagID";

	property name="name" default="" type="string";
	property name="value" type="string";
}
