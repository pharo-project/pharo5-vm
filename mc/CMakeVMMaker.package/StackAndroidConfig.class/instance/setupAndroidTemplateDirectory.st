android template generation
setupAndroidTemplateDirectory
	ressourceDir := (self buildDir / 'res') ensureCreateDirectory . 
	jniFolder := (self buildDir / 'jni') ensureCreateDirectory.
	assetDir := (self buildDir / 'assets') ensureCreateDirectory.
	