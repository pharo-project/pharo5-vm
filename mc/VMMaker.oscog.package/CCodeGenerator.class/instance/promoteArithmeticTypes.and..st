type inference
promoteArithmeticTypes: firstType and: secondType
	"Answer the return type for an arithmetic sendThis is so that the inliner can still
	 inline simple expressions.  Deal with pointer arithmetic, floating point arithmetic
	 and promotion."
	((#(#double float) includes: firstType)
	 or: [#(#double float) includes: secondType]) ifTrue:
		[^(firstType = #float and: [secondType = #float])
			ifTrue: [#float]
			ifFalse: [#double]].
	"deal with unknowns, answering nil."
	(firstType isNil or: [secondType isNil]) ifTrue:
		[^nil].
	"deal with promotion; answer the longest type, defaulting to the recever if they're the same"
	^(self sizeOfIntegralCType: firstType) >= (self sizeOfIntegralCType: secondType)
		ifTrue: [firstType]
		ifFalse: [secondType]