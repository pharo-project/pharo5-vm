private-accessing
filteredDefinitionsAsPatches: modifiedDefinitions patches: existingPatches
	^modifiedDefinitions
		select:
			[:def|
			 existingPatches noneSatisfy:
				[:addition|
				def isMethodDefinition
				and: [addition definition isMethodDefinition
				and: [addition definition selector = def selector
				and: [addition definition className = def className
				and: [addition definition classIsMeta = def classIsMeta]]]]]]
		thenCollect:
			[:def|
			 ((def source includesSubString: 'DELETEME')
				ifTrue: [MCRemoval]
				ifFalse: [MCAddition]) of: def]