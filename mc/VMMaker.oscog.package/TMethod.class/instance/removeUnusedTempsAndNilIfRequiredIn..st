utilities
removeUnusedTempsAndNilIfRequiredIn: aCodeGen
	"Remove all of the unused temps in this method. Answer a set of the references.
	 As a side-effect introduce explicit temp := nil statements for temps that are
	 tested for nil before necessarily being assigned."
	| refs readBeforeAssigned |
	refs := self removeUnusedTempsIn: aCodeGen.
	"reset the locals to be only those still referred to"
	"locals := locals select: [:e| refs includes: e].
	(locals notEmpty
	 and: [(readBeforeAssigned := (self findReadBeforeAssignedIn: locals)) notEmpty]) ifTrue:
		[readBeforeAssigned := readBeforeAssigned reject: [:v| (self declarationAt: v) beginsWith: 'extern'].
		 parseTree statements addAllFirst:
			(readBeforeAssigned asSortedCollection collect:
				[:var|
				TAssignmentNode new
					setVariable: (TVariableNode new setName: var; yourself)
					expression: (TConstantNode new setValue: 0; yourself)])]."
	^refs