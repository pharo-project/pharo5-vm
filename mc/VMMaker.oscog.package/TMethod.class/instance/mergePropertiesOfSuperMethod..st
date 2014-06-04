inlining
mergePropertiesOfSuperMethod: superTMethod
	superTMethod hasProperties ifFalse:
		[^self].
	self hasProperties ifFalse:
		[properties := superTMethod properties.
		 ^self].
	superTMethod properties pragmas do:
		[:aPragma|
		(self shouldIncorporatePragmaFromSuperMethod: aPragma) ifTrue:
			[properties := properties copyWith: aPragma]]