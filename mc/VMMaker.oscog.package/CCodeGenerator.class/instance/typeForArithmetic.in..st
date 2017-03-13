type inference
typeForArithmetic: sendNode in: aTMethod
	"Answer the return type for an arithmetic sendThis is so that the inliner can still
	 inline simple expressions.  Deal with pointer arithmetic, floating point arithmetic
	 and promotion."
	| rcvrType argType arg promotedType |
	rcvrType := self typeFor: sendNode receiver in: aTMethod.
	argType := self typeFor: (arg := sendNode args first) in: aTMethod.
	"deal with pointer arithmetic"
	((rcvrType notNil and: [rcvrType last == $*]) or: [argType notNil and: [argType last == $*]]) ifTrue:
		[(rcvrType isNil or: [argType isNil]) ifTrue:
			[^nil].
		 (rcvrType last == $* and: [argType last == $*]) ifTrue:
			[sendNode selector == #- ifTrue:
				[^#int].
			 self error: 'invalid pointer arithmetic'].
		 ^rcvrType last == $*
			ifTrue: [rcvrType]
			ifFalse: [argType]].
	promotedType := self promoteArithmeticTypes: rcvrType and: argType.
	"We have to be very careful with subtraction.  The difference between two unsigned types is signed.
	 But we don't want unsigned - constant to be signed.  We almost always want this to stay unsigned."
	^(sendNode selector == #- and: [promotedType first == $u and: [(arg isConstant and: [arg value isInteger]) not]])
		ifTrue: [promotedType allButFirst: ((promotedType beginsWith: 'unsigned') ifTrue: [9] ifFalse: [1])]
		ifFalse: [promotedType]