test support
dataRegistersWithAccessorsExcept: accessorsToExclude do: aTrinaryBlock
	self registers withIndexDo:
		[:reg :i| | getter setter |
		getter := #(rax rcx rdx rbx rsp rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15) at: i.
		setter := #(rax: rcx: rdx: rbx: rsp: rbp: rsi: rdi:  r8: r9: r10: r11: r12: r13: r14: r15:) at: i.
		(accessorsToExclude includes: getter) ifFalse:
			[aTrinaryBlock value: reg value: getter value: setter]]