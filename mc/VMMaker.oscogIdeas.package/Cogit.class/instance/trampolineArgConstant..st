initialization
trampolineArgConstant: booleanOrInteger
	"Encode true and false and 0 to N such that they can't be confused for register numbers (including NoReg)
	 and can be tested for by isTrampolineArgConstant: and decoded by trampolineArgValue:"
	<inline: true>
	self cCode: []
		inSmalltalk: [booleanOrInteger isInteger ifFalse: [^self trampolineArgConstant: (booleanOrInteger ifTrue: [1] ifFalse: [0])]].
	self assert: booleanOrInteger >= 0.
	^-2 - booleanOrInteger "0...N => -2...-(N+2)"