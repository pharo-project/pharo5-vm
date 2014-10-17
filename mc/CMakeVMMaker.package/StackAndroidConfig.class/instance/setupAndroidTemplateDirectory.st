android template generation
setupAndroidTemplateDirectory
	'../res/' asFileReference ensureDirectory.
	'../res/values/' asFileReference ensureDirectory.
	'../res/layout-xlarge-land/' asFileReference ensureDirectory.
	'../res/layout-xlarge/' asFileReference ensureDirectory.
	'../res/layout-sw720dp/' asFileReference ensureDirectory.
	'../res/layout-sw600dp/' asFileReference ensureDirectory.
	'../res/layout-large/' asFileReference ensureDirectory.
	'../res/layout/' asFileReference ensureDirectory.
	'../res/drawable/' asFileReference ensureDirectory.
	jniFolder := '../jni/' asFileReference ensureDirectory.
	'../assets/' asFileReference ensureDirectory.
	