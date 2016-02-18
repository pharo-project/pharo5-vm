disassembly
generalPurposeRegisterMap
	<doNotGenerate>
	"Answer a Dictionary from register getter to register index."
	^Dictionary newFromPairs:
		{	#rax. RAX.
			#rcx. RCX.
			#rdx. RDX.
			#rbx. RBX.
			#rsi.  RSI.
			#rdi.  RDI.
			#r8. R8.
			#r9. R9.
			#r10. R10.
			#r11. R11.
			#r12. R12.
			#r13. R13.
			#r14. R14.
			#r15. R15	}