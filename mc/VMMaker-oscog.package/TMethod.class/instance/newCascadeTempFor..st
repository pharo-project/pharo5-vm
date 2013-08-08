initialization
newCascadeTempFor: aTParseNode
	| varNode |
	cascadeVariableNumber := cascadeVariableNumber
								ifNil: [0]
								ifNotNil: [cascadeVariableNumber + 1].
	varNode := TVariableNode new setName: 'cascade', cascadeVariableNumber printString.
	aTParseNode isLeaf ifFalse:
		[declarations
			at: varNode name
			put: [:tm :cg| tm determineTypeFor: aTParseNode in: cg]].
	^varNode