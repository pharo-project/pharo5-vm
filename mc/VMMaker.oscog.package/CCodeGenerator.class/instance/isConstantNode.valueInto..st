utilities
isConstantNode: aNode valueInto: aBlock
	"Answer if aNode evaluates to a constant, and if so, evaluate aBlock with the value of that constant."

	aNode isConstant ifTrue:
		[aBlock value: aNode value.
		 ^true].
	aNode isSend ifFalse:
		[^false].
	(self anyMethodNamed: aNode selector) ifNotNil:
		[:m|
		(m statements size = 1
		 and: [m statements last isReturn]) ifTrue:
			[^self isConstantNode: m statements last expression valueInto: aBlock]].
	^false