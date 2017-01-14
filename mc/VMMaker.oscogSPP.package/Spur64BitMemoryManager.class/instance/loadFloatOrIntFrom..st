interpreter access
loadFloatOrIntFrom: floatOrIntOop
	"If floatOrInt is an integer, then convert it to a C double float and return it.
	 If it is a Float, then load its value and return it.
	 Otherwise fail -- ie return with primErrorCode non-zero."

	<inline: true>
	<returnTypeC: #double>
	| result tagBits shift |
	<var: #result type: #double>

	(tagBits := floatOrIntOop bitAnd: self tagMask) ~= 0
		ifTrue:
			[tagBits = self smallFloatTag ifTrue:
				[^self smallFloatValueOf: floatOrIntOop].
			 (tagBits = self smallIntegerTag
			  and: [shift := 64 - self numTagBits - self smallFloatMantissaBits.
				(self cCode: [floatOrIntOop << shift]
						inSmalltalk: [floatOrIntOop << shift bitAnd: 1 << 64 - 1]) >>> shift = floatOrIntOop]) ifTrue:
				[^(self integerValueOf: floatOrIntOop) asFloat]]
		ifFalse:
			[(self classIndexOf: floatOrIntOop) = ClassFloatCompactIndex ifTrue:
				[self cCode: '' inSmalltalk: [result := Float new: 2].
				 self fetchFloatAt: floatOrIntOop + self baseHeaderSize into: result.
				 ^result]].
	coInterpreter primitiveFail.
	^0.0