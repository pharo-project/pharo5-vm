plugin
ccg: cg prolog: aBlock expr: aString index: anInteger

	^cg 
		ccgLoad: aBlock 
		expr: aString 
		asNamedPtr: self asString
		from: anInteger
		andThen: (cg ccgValBlock: 'isWordsOrBytes')