patching
patchDefinition: aMCMethodDefinition withRewriter: aRBParseTreeRewriter 
	| parseTree |
	parseTree := RBParser
					parseMethod: aMCMethodDefinition source
					onError: [:str :pos | self halt].
	aRBParseTreeRewriter executeTree: parseTree.
	^MCMethodDefinition new
		initializeWithClassName: aMCMethodDefinition className
		classIsMeta:aMCMethodDefinition classIsMeta
		selector: aMCMethodDefinition selector
		category: aMCMethodDefinition category
		timeStamp: aMCMethodDefinition timeStamp
		source: aRBParseTreeRewriter tree newSource