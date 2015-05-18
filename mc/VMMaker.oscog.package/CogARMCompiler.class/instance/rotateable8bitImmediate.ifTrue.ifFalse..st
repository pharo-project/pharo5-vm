testing
rotateable8bitImmediate: constant ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock
	<inline: true>
	"For data processing operands, there is the immediate shifter_operand variant, 
	 where an 8 bit value is ring shifted _right_ by i.
	 This is only suitable for quick constants(Cq), which won't change."
	
	(constant bitAnd: 16rFF) = constant ifTrue:
		[^trueAlternativeBlock value: 0 value: constant].
	2 to: 30 by: 2 do:
		[:i |
		(constant bitAnd: ((16rFF <<i bitAnd:16rFFFFFFFF) bitOr: 16rFF>>(32-i))) = constant ifTrue:
			[^trueAlternativeBlock value: 32 - i value: ((constant >> i) bitOr: (constant <<(32 - i) bitAnd:16rFFFFFFFF))]].
	^falseAlternativeBlock value