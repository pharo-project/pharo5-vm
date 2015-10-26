printing
printRegisterStateExceptPC: registerStateVector on: aStream
	self printFields:
			((registerStateVector size < 34
			  or: [(19 to: 34) allSatisfy: [:i| (registerStateVector at: i) isZero]])
				ifTrue:
					[#(	rax rbx rcx rdx cr
						rsp rbp rsi rdi cr
						r8 r9 r10 r11 cr
						r12 r13 r14 r15 cr)]
				ifFalse:
					[#(	rax rbx rcx rdx cr
						rsp rbp rsi rdi cr
						r8 r9 r10 r11 cr
						r12 r13 r14 r15 cr
						xmm0low xmm1low cr
						xmm2low xmm3low cr
						xmm4low xmm5low cr
						xmm6low xmm7low cr )])
		inRegisterState: registerStateVector
		on: aStream