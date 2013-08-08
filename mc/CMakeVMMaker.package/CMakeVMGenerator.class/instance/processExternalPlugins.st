processing plugins
processExternalPlugins

	config externalPlugins do: [:each | | plugin gen |
		plugin := Smalltalk at: each.
		gen := plugin generateFor: self internal: false.
		gen doNotGenerate ifFalse: [
			self addSubdirectory: plugin moduleName.
			]
	].
	
