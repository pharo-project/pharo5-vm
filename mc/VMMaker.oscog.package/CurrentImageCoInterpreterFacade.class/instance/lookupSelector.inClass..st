cog jit support
lookupSelector: selectorOop inClass: classOop
	| class selector |
	class := self objectForOop: classOop.
	selector := self objectForOop: selectorOop.
	^(class canUnderstand: selector) ifTrue:
		[self oopForObject: ((class whichClassIncludesSelector: selector)
									compiledMethodAt: selector)]