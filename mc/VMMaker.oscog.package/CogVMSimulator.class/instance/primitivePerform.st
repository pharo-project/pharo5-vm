debugging traps
primitivePerform
	| selector |
	selector := self stackValue: argumentCount - 1.
	self sendBreakpoint: selector receiver: (self stackValue: argumentCount).
	(self filterPerformOf: selector to: (self stackValue: argumentCount)) ifTrue:
		[^self pop: argumentCount].
	^super primitivePerform