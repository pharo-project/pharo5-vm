C code generator
prepareTranslatedPrimitives
	"Translated primitives need their prolog and epilog adding and all
	 sends to self that should be sends to interpreterproxy changing."
	methods do:
		[:meth|
		 meth primitive > 0 ifTrue:
			[meth
				preparePrimitivePrologue;
				mapSendsFromSelfToInterpreterProxy: InterpreterProxy selectors]]