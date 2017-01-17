type inference
promoteIntegerArithmeticTypes: firstType and: secondType
	"Answer the return type for an arithmetic send.
	Deal with integer promotion rules of C99.
	See section 6.3 Conversions of the standard.
	
	6.3.1.1 ...snip...
		If an int can represent all values of the original type, the value is converted to an int;
		otherwise, it is converted to an unsigned int. These are called the integer promotions.
		All other types are unchanged by the inte ger promotions

	6.3.1.8 ...snip...
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

	This is so that the generated code behaviour is unsensitive to inlining."
	| length1 length2 intSize |
	length1 := self sizeOfIntegralCType: firstType.
	length2 := self sizeOfIntegralCType: secondType.
	intSize := self sizeOfIntegralCType: #int.
	(length1 < intSize and: [length2 < intSize]) ifTrue: [^#int].	"Integer promotion"
	length1 > length2 ifTrue: [^firstType].
	length2 > length1 ifTrue: [^secondType].
	firstType first = $u ifTrue: [^firstType].
	secondType first = $u ifTrue: [^secondType].
	^firstType