abstract instructions
genPushC64: constant64Bits
	<inline: true>
	<var: #constant64Bits type: #sqLong>
	<returnTypeC: #'AbstractInstruction *'>
	| inst highPart |
	BytesPerWord == 4 ifTrue: [
		highPart := self cCode: '(constant64Bits >> 32ll)' inSmalltalk: [ constant64Bits bitShift: -32 ].
		inst :=cogit PushCw: highPart.
		cogit PushCw: (constant64Bits bitAnd: 16rFFFFFFFF).
		^ inst
	] ifFalse: [
		^ cogit PushCw: constant64Bits.
	]