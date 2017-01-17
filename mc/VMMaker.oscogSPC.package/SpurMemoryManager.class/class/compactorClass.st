accessing class hierarchy
compactorClass
	"Answer the compaction algorithm to use."
	^Smalltalk classNamed: (initializationOptions at: #compactorClass ifAbsent: [#SpurPlanningCompactor])