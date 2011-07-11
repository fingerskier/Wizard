component persistent="true" {
	property name="ID" fieldtype="id" generated="always" generator="increment" ormtype="integer" type="numeric";
	property name="created" fieldtype="timestamp" ormtype="timestamp" setter="false";
	property name="updated" ormtype="timestamp" setter="false";

	property name="modules" cascade="all-delete-orphan" cfc="module" fieldtype="one-to-many" fkcolumn="projectID" inverse="true" singularname="module";

	property name="name" default="" ormtype="string";
	property name="path" default="" ormtype="string";

	private function preUpdate(Struct oldData) {
		variables.updated = createODBCDateTime(now());
	}
}
