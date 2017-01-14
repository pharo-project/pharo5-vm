test support
dataRegistersWithAccessorsDo: aTrinaryBlock
	self registers withIndexDo:
		[:reg :i|
		aTrinaryBlock
			value: reg
			value: (#(rax rcx rdx rbx rsp rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15) at: i)
			value: (#(rax: rcx: rdx: rbx: rsp: rbp: rsi: rdi:  r8: r9: r10: r11: r12: r13: r14: r15:) at: i)]