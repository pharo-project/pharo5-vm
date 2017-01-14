utilities
isConstantNode: aNode valueInto: aBlock
	"Answer if aNode evaluates to a constant, and if so, evaluate aBlock with the value of that constant."

	aNode isConstant ifTrue:
		[(aNode isDefine
		  and: [(vmClass ifNil: [VMBasicConstants]) defineAtCompileTime: aNode name]) ifTrue:
			[^false].
		 aBlock value: aNode value.
		 ^true].
	(aNode isVariable
	 and: [aNode name = #nil]) ifTrue:
		[aBlock value: nil.
		 ^true].
	aNode isSend ifFalse:
		[^false].
	(self anyMethodNamed: aNode selector)
		ifNil:
			[(VMBasicConstants valueOfBasicSelector: aNode selector) ifNotNil:
				[:value|
				 aBlock value: value.
				 ^true]]
		ifNotNil:
			[:m|
			(m statements size = 1
			 and: [m statements last isReturn]) ifTrue:
				[^self isConstantNode: m statements last expression valueInto: aBlock]].
	^false