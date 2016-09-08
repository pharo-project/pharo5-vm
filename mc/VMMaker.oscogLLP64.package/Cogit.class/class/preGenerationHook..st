translation
preGenerationHook: aCCodeGenerator
	"Perform any last-minute changes to the code generator immediately
	 before it performs code analysis and generation.  In this case, make
	 all non-exported methods private."
	| exportAPISelectors |
	exportAPISelectors := self exportAPISelectors: aCCodeGenerator options.
	aCCodeGenerator selectorsAndMethodsDo:
		[:s :m|
		(exportAPISelectors includes: s)
			ifTrue: [m static: false]
			ifFalse:
				[m export ifFalse:
					[m static: true]]]