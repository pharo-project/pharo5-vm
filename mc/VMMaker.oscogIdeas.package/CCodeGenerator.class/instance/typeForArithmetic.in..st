type inference
typeForArithmetic: sendNode in: aTMethod
	"Answer the return type for an arithmetic sendThis is so that the inliner can still
	 inline simple expressions.  Deal with pointer arithmetic, floating point arithmetic
	 and promotion."
	| rcvrType argType |
	rcvrType := self typeFor: sendNode receiver in: aTMethod.
	argType := self typeFor: sendNode args first in: aTMethod.
	"deal with pointer arithmetic"
	((rcvrType notNil and: [rcvrType last = $*]) or: [argType notNil and: [argType last = $*]]) ifTrue:
		[(rcvrType isNil or: [argType isNil]) ifTrue:
			[^nil].
		 (rcvrType last = $* and: [argType last = $*]) ifTrue:
			[sendNode selector == #- ifTrue:
				[^#int].
			 self error: 'invalid pointer arithmetic'].
		 ^rcvrType last = $*
			ifTrue: [rcvrType]
			ifFalse: [argType]].
	^self promoteArithmeticTypes: rcvrType and: argType