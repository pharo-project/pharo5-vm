spur primitive compilation
isObjectAccessor: selector given: interpreterClass
	"Override to include the selectors transformed into accessors for translated primitives.
	 InterpreterPlugin browseTranslatedPrimitives"
	^(#(asciiValue at: at:put: basicAt: size) includes: selector)
	  or: [super isObjectAccessor: selector given: interpreterClass]