code generation
generate: aPlugin for: aCMakeVMGenerator internal: aBoolean extraRules: aBlock

	doNotGenerate := false.
	internal := aBoolean.
	plugin := aPlugin.
	vmGen := aCMakeVMGenerator.
	extraRules := aBlock.
		
	^ self generate