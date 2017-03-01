debugging traps
primitivePerform
	| receiver selector |
	"If called from the machine code perform primitive, it should not have been found,
	 except that the cacheing for V3 has a mismatch between that used ror the first-level
	 method cache and inline caches."
	receiver := (self stackValue: argumentCount).
	selector := self stackValue: argumentCount - 1.
	((self methodHasCogMethod: newMethod)
	 and: [(objectMemory isCompactInstance: receiver) not]) ifTrue:
		[self deny: (self newMethodInLookupCacheAt: selector and: (objectMemory fetchClassTagOf: receiver))].
	self sendBreakpoint: selector receiver: receiver.
	(self filterPerformOf: selector to: receiver) ifTrue:
		[^self pop: argumentCount].
	^super primitivePerform