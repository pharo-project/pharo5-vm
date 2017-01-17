generate sources
generatePlugins
	"Generate the ``external'' plugins.
	 If this comes from a generator, log it for convenience."
	abortBlock := [^self].
	self configurationGeneratorNameOrNil ifNotNil:
		[:generator|
		 logger cr; nextPutAll: (generator selector copyReplaceAll: 'generate' with: '').
		 interpreterClassName ifNotNil:
			[logger space; nextPutAll: (CCodeGenerator shortMonticelloDescriptionForClass: (Smalltalk classNamed: interpreterClassName))].
		 logger cr; flush].
	self generateExternalPlugins