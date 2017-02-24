cog jit support
lookupOrdinary: selectorOop receiver: receiverOop
	| rcvr selector |
	rcvr := self objectForOop: receiverOop.
	selector := self objectForOop: selectorOop.
	(rcvr class canUnderstand: selector) ifTrue:
		[^self oopForObject: ((rcvr class whichClassIncludesSelector: selector)
									compiledMethodAt: selector)].
	^SelectorDoesNotUnderstand