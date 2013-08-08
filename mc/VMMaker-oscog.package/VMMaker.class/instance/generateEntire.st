generate sources
generateEntire
	"Generate the interp, internal plugins and exports as well as the external plugins.
	 If this comes from a generator, log it for convenience."
	(thisContext findContextSuchThat: [:ctxt| ctxt selector == #generateConfiguration]) ifNotNil:
		[:root|
		(thisContext findContextSuchThat: [:ctxt| ctxt sender == root]) ifNotNil:
			[:generator|
			logger cr; nextPutAll: (generator selector copyReplaceAll: 'generate' with: '').
			interpreterClassName ifNotNil: [logger space; nextPutAll: interpreterClassName].
			logger cr; flush]].
	self generateMainVM.
	self generateExternalPlugins