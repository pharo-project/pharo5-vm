translation
preGenerationHook: aCCodeGenerator
	"Perform any last-minute changes to the code generator immediately
	 before it performs code analysis and generation.  In this case, make
	 all non-exported methods private."
	| publicMethodNames |
	publicMethodNames := (self requiredMethodNames: aCCodeGenerator options)
								copyWithoutAll: (self primitiveTable
														copyWithout: #primitiveFail).
	aCCodeGenerator selectorsAndMethodsDo:
		[:s :m|
		(m export or: [publicMethodNames includes: s]) ifTrue:
			[m static: false]]