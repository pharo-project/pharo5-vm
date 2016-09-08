in-line cacheing
genLoadInlineCacheWithSelector: selectorIndex
	"The in-line cache for a send is implemented as a constant load into ClassReg.
	 We always use a 32-bit load, even in 64-bits.

	 In the initial (unlinked) state the in-line cache is notionally loaded with the selector.
	 But since in 64-bits an arbitrary selector oop won't fit in a 32-bit constant load, we
	 instead load the cache with the selector's index, either into the literal frame of the
	 current method, or into the special selector array.  Negative values are 1-relative
	 indices into the special selector array.

	 When a send is linked, the load of the selector, or selector index, is overwritten with a
	 load of the receiver's class, or class tag.  Hence, the 64-bit VM is currently constrained
	 to use class indices as cache tags.  If out-of-line literals are used, distinct caches /must
	 not/ share acche locations, for if they do, send cacheing will be confused by the sharing.
	 Hence we use the MoveUniqueC32:R: instruction that will not share literal locations."

	| cacheValue |
	self assert: (selectorIndex < 0
					ifTrue: [selectorIndex negated between: 1 and: self numSpecialSelectors]
					ifFalse: [selectorIndex between: 0 and: (objectMemory literalCountOf: methodObj) - 1]).

	self inlineCacheTagsAreIndexes
		ifTrue:
			[cacheValue := selectorIndex]
		ifFalse:
			[| selector |
			 selector := selectorIndex < 0
							ifTrue: [(coInterpreter specialSelector: -1 - selectorIndex)]
							ifFalse: [self getLiteral: selectorIndex].
			 self assert: (objectMemory addressCouldBeOop: selector).
			 (objectMemory isYoung: selector) ifTrue:
				[hasYoungReferent := true].
			 cacheValue := selector].

	self MoveUniqueC32: cacheValue R: ClassReg