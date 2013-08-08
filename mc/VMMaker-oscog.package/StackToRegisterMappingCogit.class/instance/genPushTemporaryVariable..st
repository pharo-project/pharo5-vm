bytecode generators
genPushTemporaryVariable: index
	^self ssPushDesc: (simStack at: index)