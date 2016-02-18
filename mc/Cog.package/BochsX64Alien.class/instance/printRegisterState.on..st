printing
printRegisterState: registerStateVector on: aStream
	"Print the registers, somewhat nicely formatted"
	| lastIndex |
	"First find out what floating point registers are used, and only print the ones up through the last non-zero one."
	lastIndex := (registerStateVector size to: 19 by: -1) detect: [:i| (registerStateVector at: i) ~= 0] ifNone: [0].
	lastIndex := lastIndex > 0
					ifTrue: [lastIndex - 18 + 1 // 2 * 3 + 23]
					ifFalse: [23].
	self printFields:
			(#(	rax rbx rcx rdx cr
				rsp rbp rsi rdi cr
				r8 r9 r10 r11 cr
				r12 r13 r14 r15 cr
				rip rflags cr
				xmm0low xmm1low cr
				xmm2low xmm3low cr
				xmm4low xmm5low cr
				xmm6low xmm7low cr
				xmm8low xmm9low cr
				xmm10low xmm11low cr
				xmm12low xmm13low cr
				xmm14low xmm15low cr )
					copyFrom: 1 to: lastIndex)
		inRegisterState: registerStateVector
		on: aStream