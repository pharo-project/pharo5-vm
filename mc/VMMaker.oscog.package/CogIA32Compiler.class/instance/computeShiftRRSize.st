generate machine code
computeShiftRRSize
	"On the x86 the only instructions that shift by the value of a
	 register require the shift count to be  in %ecx.  So we may
	 have to use swap instructions to get the count into ecx."
	| shiftCountReg |
	shiftCountReg := operands at: 0.
	^shiftCountReg = ECX
		ifTrue: [2]
		ifFalse:
			[shiftCountReg = EAX
				ifTrue: [1 "XCHG EAX,r2" + 2 "Sxx" + 1 "XCHG EAX,r2"]
				ifFalse: [2 "XCHG r1,r2" + 2 "Sxx" + 2 "XCHG r1,r2"]]