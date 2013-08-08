accessing
numLowLevelLockOpcodes
	"push $ebx
	 movl #0, %eax
	 movl 1, $ebx
	 mfence
	 lock cmpxchg %eax, &vmOwnerLock; # N.B. 2 instructions
	 pop $ebx
	 jnz locked
	 sfence
	 movl 1, $eax
	 ret
	locked:								; N.B. Requires an instruction
	 movl 0, $eax
	 ret"
	^14