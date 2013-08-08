utilities
addMethod: aTMethod
	"Add the given method to the code base and answer it.
	 Only allow duplicate definitions for struct accessors, since we don't actually
	 generate code for these methods and hence the conflict doesn't matter."

	(methods at:  aTMethod selector ifAbsent: []) ifNotNil:
		[:conflict |
		(conflict isStructAccessor
		 and: [aTMethod isStructAccessor
		 and: [conflict compiledMethod decompileString = aTMethod compiledMethod decompileString]]) ifTrue:
			[^nil].
		self error: 'Method name conflict: ', aTMethod selector].
	^methods at: aTMethod selector put: aTMethod