printing
printRegisterState: registerStateVector on: aStream
	"Print the registers, somewhat nicely formatted"
	| lastIndex |
	"First find out what floating point registers are used, and only print the ones up through the last non-zero one."
	lastIndex := (registerStateVector size to: 11 by: -1) detect: [:i| (registerStateVector at: i) ~= 0] ifNone: [0].
	 lastIndex := lastIndex > 0
					ifTrue: [lastIndex - 10 + 1 // 2 * 3 + 13]
					ifFalse: [13].
	self printFields:
			(#(	eax ebx ecx edx cr
				esp ebp esi edi cr
				eip eflags cr
				xmm0low xmm1low cr
				xmm2low xmm3low cr
				xmm4low xmm5low cr
				xmm6low xmm7low cr )
					copyFrom: 1 to: lastIndex)
		inRegisterState: registerStateVector
		on: aStream