utilities
addMethod: aTMethod
	"Add the given method to the code base and answer it.
	 Only allow duplicate definitions for struct accessors, since we don't actually
	 generate code for these methods and hence the conflict doesn't matter.
	 Allow subclasses to redefine methods (Smalltalk has inheritance after all)."

	(methods at: aTMethod selector ifAbsent: []) ifNotNil:
		[:conflict |
		aTMethod compiledMethod isSubclassResponsibility ifTrue:
			[^nil].
		(conflict isStructAccessor
		 and: [aTMethod isStructAccessor
		 and: [conflict compiledMethod decompileString = aTMethod compiledMethod decompileString]]) ifTrue:
			[^nil].
		((aTMethod definingClass inheritsFrom: conflict definingClass)
		 or: [(aTMethod compiledMethod pragmaAt: #option:) notNil]) ifFalse:
			[self error: 'Method name conflict: ', aTMethod selector]].
	^methods at: aTMethod selector put: aTMethod