public
generateSources
	self setupAndroidTemplateDirectory.
	self generateJavaSources.
	self createAndroidManifest.
	super generateSources.