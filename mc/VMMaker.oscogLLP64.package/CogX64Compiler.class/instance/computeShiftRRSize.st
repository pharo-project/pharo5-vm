generate machine code
computeShiftRRSize
	"On the x86 the only instructions that shift by the value of a
	 register require the shift count to be  in %ecx.  So we may
	 have to use swap instructions to get the count into ecx."
	| shiftCountReg |
	shiftCountReg := operands at: 0.
	^shiftCountReg = RCX
		ifTrue: [3]
		ifFalse:
			[shiftCountReg = RAX
				ifTrue: [2 "XCHG RAX,r2" + 3 "Sxx" + 2 "XCHG RAX,r2"]
				ifFalse: [3 "XCHG r1,r2" + 3 "Sxx" + 3 "XCHG r1,r2"]]