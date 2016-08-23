interpreter access
dbgFloatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or if it is not, answer 0."

	| result tagBits |
	<returnTypeC: #double>
	<var: #result type: #double>
	(tagBits := oop bitAnd: self tagMask) ~= 0
		ifTrue:
			[tagBits = self smallFloatTag ifTrue:
				[^self smallFloatValueOf: oop]]
		ifFalse:
			[(self classIndexOf: oop) = ClassFloatCompactIndex ifTrue:
				[self cCode: '' inSmalltalk: [result := Float new: 2].
				 self fetchFloatAt: oop + self baseHeaderSize into: result.
				 ^result]].
	^0.0