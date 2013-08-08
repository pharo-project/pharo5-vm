accessing
stackPageInterruptHeadroomBytes
	"Return a minimum amount of headroom for each stack page (in bytes).  In a
	 JIT the stack has to have room for interrupt handlers which will run on the stack.
	According to ARM architecture v5 reference manual chapter A2.6, the basic interrupt procedure does not push anything onto the stack. It uses SPSR_err and R14_err to preserve state. Afterwards, it calls an interrupt procedure. So leave some room."
	^128 "32 words"