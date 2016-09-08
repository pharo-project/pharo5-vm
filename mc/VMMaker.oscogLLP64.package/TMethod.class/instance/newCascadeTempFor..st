initialization
newCascadeTempFor: aTParseNode
	| varName varNode |
	varName := self extraVariableName: 'cascade'.
	varNode := TVariableNode new setName: varName.
	aTParseNode isLeaf ifFalse:
		[self
			declarationAt: varName
			put: [:tm :cg| | type |
				type := tm determineTypeFor: aTParseNode in: cg.
				(VMStructType structTargetKindForType: type) == #struct ifTrue:
					["can't copy structs into cascade temps; the struct is not updated.
					  must change to a pointer."
					type := type, ' *'.
					parseTree nodesDo:
						[:node|
						(node isAssignment
						 and: [node variable name = varName]) ifTrue:
							[node setExpression: (TSendNode new
													setSelector: #addressOf:
													receiver: (TVariableNode new setName: 'self')
													arguments: {node expression})]]].
				type]].
	^varNode