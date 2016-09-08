initialize-release
initialiseModule
	<export: true>
	self initBBOpTable.
	self initDither8Lookup.
	self cppIf: #'ENABLE_FAST_BLT'
		ifTrue:[self initialiseCopyBits].
	^true