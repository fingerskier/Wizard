﻿component persistent="true" {
	property name="ID" fieldtype="id" generator="native" ormtype="integer" type="numeric";

	property name="project" cfc="project" fieldtype="many-to-one" fkcolumn="projectID";
	property name="tags" cascade="all-delete-orphan" cfc="tag" fieldtype="one-to-many" fkcolumn="moduleID" inverse="true" singularname="tag";

	property name="name" default="" ormtype="string";
	property name="folder" ormtype="boolean";

	public boolean function isFolder() {
		var isit = getFolder();

		if (isDefined('isit') and isBoolean(isit) and isit) {
			return true;
		} else {
			return false;
		}
	}
}
