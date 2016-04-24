type inference
promoteArithmeticTypes: firstType and: secondType
	"Answer the return type for an arithmetic send.  This is so that the inliner can still inline
	 simple expressions.  Deal with pointer arithmetic, floating point arithmetic and promotion.
	 It is important to choose deterministically to get stable source generation.
	 Also, the behaviour of inlined and non inlined code should be unchanged."
	((#(#double float) includes: firstType)
	 or: [#(#double float) includes: secondType]) ifTrue:
		[^(firstType = #double or: [secondType = #double])
			ifTrue: [#double]
			ifFalse: [#float] "in C99 6.3.1.8, float+int, int is converted as a float"].
	"deal with unknowns, answering nil."
	(firstType isNil or: [secondType isNil]) ifTrue:
		[^nil].
	"Deal with integer promotion and arithmetic conversion"
	^self promoteIntegerArithmeticTypes: firstType and: secondType