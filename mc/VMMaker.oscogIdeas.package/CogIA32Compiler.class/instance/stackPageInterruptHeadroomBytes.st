accessing
stackPageInterruptHeadroomBytes
	"Return a minimum amount of headroom for each stack page (in bytes).  In a
	 JIT the stack has to have room for interrupt handlers which will run on the stack.
	 See [1] pp 6-13 to 6-14.  On an interrupt or exception the maximum state that
	 an IA32 CPU will push is SS, ESP, EFLAGS, CS, EIP and an error code.  It may then
	 call an interrupt procedure.  Leave some room above the minimum state."
	^256