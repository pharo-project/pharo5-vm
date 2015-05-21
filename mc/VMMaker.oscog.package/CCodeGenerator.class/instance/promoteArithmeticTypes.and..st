type inference
promoteArithmeticTypes: firstType and: secondType
	"Answer the return type for an arithmetic send.  This is so that the inliner can still inline
	 simple expressions.  Deal with pointer arithmetic, floating point arithmetic and promotion."
	| firstSize secondSize |
	((#(#double float) includes: firstType)
	 or: [#(#double float) includes: secondType]) ifTrue:
		[^(firstType = #float and: [secondType = #float])
			ifTrue: [#float]
			ifFalse: [#double]].
	"deal with unknowns, answering nil."
	(firstType isNil or: [secondType isNil]) ifTrue:
		[^nil].
	"Deal with promotion; answer the longest type, defaulting to the recever if they're the same.
	 See e.g. section 6.3.1.8 Usual arithmetic conversions, from the C99 standard:
		Otherwise, the integer promotions are performed on both operands
		Then the following rules are applied to the promoted operands:

			If both operands have the same type, then no further conversion is needed.

			Otherwise, if both operands have signed integer types or both have unsigned integer
			types, the operand with the type of lesser integer conversion rank is converted to the
			type of the operand with greater rank.

			Otherwise, if the operand that has unsigned integer type has rank greater or equal to
			the rank of the type of the other operand, then the operand with signed integer type
			is converted to the type of the operand with unsigned integer type.

			Otherwise, if the type of the operand with signed integer type can represent all of the
			values of the type of the operand with unsigned integer type, then the operand with
			unsigned integer type is converted to the type of the operand with signed integer type.

			Otherwise, both operands are converted to the unsigned integer type corresponding to
			the type of the operand with signed integer type.

	It is important to choose deterministically to get stable source generation.  So if the types have
	the same size but differ in signedness we choose the unsigned type, which is in partial agreement
	with the above"
	^(firstSize := self sizeOfIntegralCType: firstType) = (secondSize := self sizeOfIntegralCType: secondType)
		ifTrue:
			[(firstType first = $u)
				ifTrue: [firstType]
				ifFalse: [(secondType first = $u) ifTrue: [secondType] ifFalse: [firstType]]]
		ifFalse:
			[firstSize > secondSize ifTrue: [firstType] ifFalse: [secondType]]