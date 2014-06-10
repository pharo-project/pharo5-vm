translation
preGenerationHook: aCCodeGen
	"Perform any last-minute changes to the code generator immediately
	 before it performs code analysis and generation.  In this case, make
	 all non-exported methods private."
	| publicMethodNames |
	self primitiveTable do:
		[:s|
		(s isSymbol and: [s ~~ #primitiveFail]) ifTrue:
			[(aCCodeGen methodNamed: s) returnType: #void]].
	publicMethodNames := (self requiredMethodNames: aCCodeGen options)
								copyWithoutAll: (self primitiveTable
														copyWithout: #primitiveFail).
	aCCodeGen selectorsAndMethodsDo:
		[:s :m|
		(m export or: [publicMethodNames includes: s]) ifTrue:
			[m static: false]]