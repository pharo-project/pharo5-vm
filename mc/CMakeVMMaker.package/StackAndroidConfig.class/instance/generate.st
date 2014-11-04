public
generate
	self setupAndroidTemplateDirectory.
	self setupAndroidRessources.
	^ CMakeAndroidVMGenerator generate: self 