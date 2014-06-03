printing
printRegisterStateExceptPC: registerStateVector on: aStream
	self printFields:
			((registerStateVector size < 18
			  or: [(11 to: 18) allSatisfy: [:i| (registerStateVector at: i) isZero]])
				ifTrue:
					[#(	eax ebx ecx edx cr
						esp ebp esi edi cr)]
				ifFalse:
					[#(	eax ebx ecx edx cr
						esp ebp esi edi cr
						xmm0low xmm1low cr
						xmm2low xmm3low cr
						xmm4low xmm5low cr
						xmm6low xmm7low cr )])
		inRegisterState: registerStateVector
		on: aStream