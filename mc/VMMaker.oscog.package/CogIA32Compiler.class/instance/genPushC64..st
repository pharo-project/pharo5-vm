abstract instructions
genPushC64: constant64Bits
	<inline: true>
	<var: #constant64Bits type: #sqLong>
	<returnTypeC: #'AbstractInstruction *'>
	| inst highPart |
	self assert: BytesPerWord = 4.
	highPart := self cCode: '(constant64Bits >> 32LL)' inSmalltalk: [ constant64Bits bitShift: -32 ].
	inst :=cogit PushCw: highPart.
	cogit PushCw: (constant64Bits bitAnd: 16rFFFFFFFF).
	^inst