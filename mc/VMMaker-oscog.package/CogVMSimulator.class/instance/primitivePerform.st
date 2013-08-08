debugging traps
primitivePerform
	| selector |
	selector := self stackValue: argumentCount - 1.
	self sendBreak: selector + BaseHeaderSize
		point: (objectMemory lengthOf: selector)
		receiver: (self stackValue: argumentCount).
	(self filterPerformOf: selector to: (self stackValue: argumentCount)) ifTrue:
		[^self pop: argumentCount].
	^super primitivePerform