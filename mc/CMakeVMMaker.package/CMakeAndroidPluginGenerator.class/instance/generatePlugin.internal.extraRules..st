plugins
generatePlugin: aPlugin internal: aBoolean extraRules: aBlock
	doNotGenerate := false.
	internal := aBoolean.
	plugin := aPlugin.
	vmGen := CMakeAndroidVMGenerator new.
	extraRules := aBlock.
		
	^ self generate