utilities
removeUnusedTempsAndNilIfRequiredIn: aCodeGen
	"Remove all of the unused temps in this method. Answer a set of the references.
	 As a side-effect introduce explicit temp := nil statements for temps that are
	 tested for nil before necessarily being assigned."
	| refs readBeforeAssigned simplyTypedLocals |
	refs := self removeUnusedTempsIn: aCodeGen.
	"reset the locals to be only those still referred to"
	locals := locals select: [:e| refs includes: e].
	(locals notEmpty
	 and: [aCodeGen
			pushScope: declarations
			while: [simplyTypedLocals := locals select:
											[:var|
											 declarations
												at: var
												ifPresent: [:decl| aCodeGen isSimpleType: (aCodeGen extractTypeFor: var fromDeclaration: decl)]
												ifAbsent: [true]].
				(readBeforeAssigned := (self findReadBeforeAssignedIn: simplyTypedLocals in: aCodeGen)) notEmpty]]) ifTrue:
		[readBeforeAssigned := readBeforeAssigned reject:
			[:v| | d | "don't initialize externs, arrays or the explicitly initialized."
			 d := self declarationAt: v.
			 (d beginsWith: 'extern') or: [(d includes: $[) or: [d includes: $=]]].
		 parseTree statements addAllFirst:
			(readBeforeAssigned asSortedCollection collect:
				[:var|
				TAssignmentNode new
					setVariable: (TVariableNode new setName: var; yourself)
					expression: (TConstantNode new setValue: 0; yourself)])].
	^refs