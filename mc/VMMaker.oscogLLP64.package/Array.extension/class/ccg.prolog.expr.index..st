*VMMaker-plugin generation
ccg: cg prolog: aBlock expr: aString index: anInteger

	^cg 
		ccgLoad: aBlock 
		expr: aString 
		asOopPtrFrom: anInteger
		andThen: (cg ccgValBlock: 'isIndexable')