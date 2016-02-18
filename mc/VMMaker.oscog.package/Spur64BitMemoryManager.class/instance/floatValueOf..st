interpreter access
floatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or fail if it is not a Float, and answer 0.
	 Note: May be called by translated primitive code."

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
	coInterpreter primitiveFail.
	^0.0