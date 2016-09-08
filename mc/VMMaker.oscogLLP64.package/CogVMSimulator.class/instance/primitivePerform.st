debugging traps
primitivePerform
	| selector |
	"If called from the machine code perform primitive, it should not have been found."
	selector := self stackValue: argumentCount - 1.
	(self methodHasCogMethod: newMethod) ifTrue:
		[self deny: (self newMethodInLookupCacheAt: selector and: (objectMemory fetchClassTagOf: (self stackValue: argumentCount)))].
	self sendBreakpoint: selector receiver: (self stackValue: argumentCount).
	(self filterPerformOf: selector to: (self stackValue: argumentCount)) ifTrue:
		[^self pop: argumentCount].
	^super primitivePerform