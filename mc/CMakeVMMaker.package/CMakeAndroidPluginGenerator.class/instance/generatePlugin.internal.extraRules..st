plugins
generatePlugin: aPlugin internal: aBoolean extraRules: aBlock
	doNotGenerate := false.
	internal := aBoolean.
	plugin := aPlugin.
	vmGen := CMakeAndroidGenerator.
	extraRules := aBlock.
		
	^ self generate