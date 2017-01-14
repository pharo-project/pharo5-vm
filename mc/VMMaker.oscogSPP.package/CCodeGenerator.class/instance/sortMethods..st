utilities
sortMethods: aTMethodCollection
	"We need to define this since different Squeak versions answer different results
	 for asSortedCollection and if sort order changes, generated code changes too.
	 When generating VM code, use class name as major sort index as this groups
	 some methods by functionality (e.g. SpurGenerationScavenger) and that makes
	 the VMProfiler more useful."
	^aTMethodCollection asSortedCollection:
		(self isGeneratingPluginCode
			ifTrue:
				[[:a :b| a selector caseSensitiveLessOrEqual: b selector]]
			ifFalse:
				[[:a :b|
				  a definingClass = b definingClass
					ifTrue: [a selector caseSensitiveLessOrEqual: b selector]
					ifFalse: [a definingClass name caseSensitiveLessOrEqual: b definingClass name]]])