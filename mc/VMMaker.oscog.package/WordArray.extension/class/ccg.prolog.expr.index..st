*VMMaker-plugin generation
ccg: cg prolog: aBlock expr: aString index: anInteger

	^cg 
		ccgLoad: aBlock 
		expr: aString 
		asUnsignedPtrFrom: anInteger
		andThen: (cg ccgValBlock: 'isWords')