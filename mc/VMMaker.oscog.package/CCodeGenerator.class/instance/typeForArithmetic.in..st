type inference
typeForArithmetic: sendNode in: aTMethod
	"Answer the return type for an arithmetic sendThis is so that the inliner can still
	 inline simple expressions.  Deal with pointer arithmetic, floating point arithmetic
	 and promotion."
	| rcvrType argType |
	argType := self typeFor: sendNode args first in: aTMethod.
	argType = #double ifTrue:
		[^#double].
	rcvrType := self typeFor: sendNode receiver in: aTMethod.
	"deal with unknowns, answering nil."
	(rcvrType isNil or: [argType isNil]) ifTrue:
		[^nil].
	"deal with pointer arithmetic"
	(rcvrType last = $* or: [argType last = $*]) ifTrue:
		[(sendNode selector == #-
		  and: [rcvrType last = $* and: [argType last = $*]]) ifTrue:
			[^#int].
		 ^rcvrType last = $
			ifTrue: [rcvrType]
			ifFalse: [argType]].
	"deal with promotion; answer the longest type, defaulting to the recever if they're the same"
	^(self sizeOfIntegralCType: rcvrType) >= (self sizeOfIntegralCType: argType)
		ifTrue: [rcvrType]
		ifFalse: [argType]