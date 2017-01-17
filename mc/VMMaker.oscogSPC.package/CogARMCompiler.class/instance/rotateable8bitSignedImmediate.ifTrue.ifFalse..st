testing
rotateable8bitSignedImmediate: constant ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock
	<inline: true>
	"Invoke trueAlternativeBlock with shift, value and negated if constant can be represented
	 by a possibly rotated 8-bit constant, otherwise invoke falseAlternativeBlock. For data
	 processing operands, there is the immediate shifter_operand variant,  where an 8 bit value
	 is ring shifted _right_ by i. This is only suitable for quick constants (Cq), which won't change."
	| value |
	value := constant.
	[(value bitAnd: 16rFF) = value ifTrue:
		[^trueAlternativeBlock value: 0 value: value value: constant ~= value].
	 2 to: 30 by: 2 do:
		[:i |
		(value bitAnd: ((16rFF <<i bitAnd:16rFFFFFFFF) bitOr: 16rFF>>(32-i))) = value ifTrue:
			[^trueAlternativeBlock
				value: 32 - i
				value: ((value >> i) bitOr: (value <<(32 - i) bitAnd:16rFFFFFFFF))
				value: constant ~= value]].
	 value = constant and: [constant ~= 0]]
		whileTrue:
			[value := constant negated].
	^falseAlternativeBlock value