testing
rotateable8bitImmediate: constant ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock
	"For data processing operands, there is the immediate shifter_operand variant, 
	where an 8 bit value is ring shifted _right_ by 2*i.
	This is only suitable for quick constant(Cq), which don't change."
	
	(constant bitAnd: 16rFF) = constant ifTrue: [ ^trueAlternativeBlock value: 0 value: constant].
	1 to: 15 do: [:i |
		(constant bitAnd: 16rFF << (i<<1)) = constant 
			ifTrue: [ ^trueAlternativeBlock value: 16 - i value: constant >> (i << 1)]].
	^falseAlternativeBlock value