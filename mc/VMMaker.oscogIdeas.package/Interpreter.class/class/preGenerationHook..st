translation
preGenerationHook: aCCodeGenerator
	"Perform any last-minute changes to the code generator immediately
	 before it performs code analysis and generation.  In this case, make
	 all non-exported methods private."
	| requiredMethodNames |
	requiredMethodNames := self requiredMethodNames: aCCodeGenerator options.
	aCCodeGenerator selectorsAndMethodsDo:
		[:s :m|
		(m export or: [requiredMethodNames includes: s]) ifTrue:
			[m static: false]]