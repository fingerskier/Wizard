component persistent="true" {
	property name="ID" fieldtype="id" generated="always" generator="increment" ormtype="integer" type="numeric";
	property name="created" fieldtype="timestamp" ormtype="timestamp" setter="false";
	property name="updated" ormtype="timestamp" setter="false";

	property name="module" cfc="module" fieldtype="many-to-one" fkcolumn="moduleID";
	property name="attrs" cascade="all-delete-orphan" cfc="attr" fieldtype="one-to-many" fkcolumn="tagID" inverse="true" singularname="attr";
	property name="parent" default="0" ormtype="integer";

	property name="name" ormtype="string";
	property name="lineNum" default="1" ormtype="integer";
}
