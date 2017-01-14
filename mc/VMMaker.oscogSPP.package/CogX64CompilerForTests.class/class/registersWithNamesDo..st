test support
registersWithNamesDo: aBinaryBlock
	self registers
		with: #('%rax' '%rcx' '%rdx' '%rbx' '%rsp' '%rbp' '%rsi' '%rdi' '%r8' '%r9' '%r10' '%r11' '%r12' '%r13' '%r14' '%r15')
		do: aBinaryBlock