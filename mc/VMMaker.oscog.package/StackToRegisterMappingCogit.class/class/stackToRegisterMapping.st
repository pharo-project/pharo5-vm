documentation
stackToRegisterMapping
	"Stack to register mapping is enabled via a simulation stack { simStack. simStackPtr, simSpillBase } of
	 operand descriptors (CogSimStackEntry) which serve
		- to avoid pushing operands to the actual stack by deferring operand manipulation until an
		  operand-consuming operation (send, store, run-time call)
		- to record operand type information for constants to avoid unnecessary type checks (e.g. tag checks)
		- as a simple register allocator since any live registers are recorded in descriptors on the stack.

	The operand types are
		SSBaseOffset - a value in memory at an offset relative to some register.  For method receiver args
						 and temps the base register is  FPReg (in a frameful method).  For indirect temps
						 the register could be any unassigned register.
		SSConstant - a method literal, hence a Smalltalk object
		SSRegister - the result of an expression assigned to a register
		SSSpill - a value spilled to the actual stack
	The special descriptor simSelf defines self in the current method, relative to FPReg in frameful
	 methods and  in a register in frameless methods.

	The register allocator aspect allocates registers by searching for SSBaseOffset and SSRegister
	 descriptors, computing the set of live registers, and then enumerating to find unused ones.
	 Simulation stack contents must be spilled to the actual stack
		- at a send (since at a suspension point the actual stack must be valid),
		- to make a register available if the code generator needs it
		- at a control flow join (since the two control flows could compute different stack contents and
		  we choose to avoid the complexity of saving stack contents to allow merging at join points).

	At a control-flow join we must discard type information for values pushed to the stack in either
	arm of the control-flow, but need /not/ for items pushed before the control flow diverged.  e.g. in
		self at: 1 put: (expr ifTrue: [v1] ifFalse: [v2]).
	the 1 is still valid after the control flow join for (expr ifTrue: [v1] ifFalse: [v2]).  So at a conditional
	branch we record simStackPtr in the target fixup and only void types between it and the
	simStackPtr at the join point.  This type voiding operation is called merge:.  For now we simply throw
	away all type info but would like to implement the baove scheme soon.

	 We can determine the stack depth at a conditional branch (if), but how do we determine the stack
	 depth following an unconditional jump (else)?  There are essentially three cases
		e ifTrue: [u] ifFalse: [v],
		e ifTrue: [^u] ifFalse: [v],
		e ifTrue: [u] ifFalse: [^v]

		1		expr
		2		jumpCond L1
		3		push
		4		jump L2
		5	L1:
		6		push
		7	L2:

		1		expr
		2		jumpCond L1
		3		ret
		4	L1:
		5		push

		1		expr
		2		jumpCond L1
		3		push
		4		jump L2
		5	L1:
		6		ret
		7	L2:

	In the first case we can know the merge base at L2 by propagating the merge base from 4 jump L2, which
	precedes the target of 2 jumpCond L1.  i.e. the merge base at 7 L2 is the stack pointer at 4 jump L2, which
	precedes the target of 2 jumpCond L1.  So at 2 jumpCond L1 we copy the stack pointer to the merge base
	at 5 L1, /and/ to the preceding 4 jump L2, and when we reach 4 jump L2, propagate the merge base to 7 L2.

	 Since we're conscious of JIT performance we restrict the live register search range by maintaining
	 simSpillBase, which is the index of the unspilled entry furthest from the end of simulation stack.
	 Only entries from simSpillBase to simStackPtr can contain unspilled, and hence live and volatile
	 registers (the FPReg is not volatile).

	 We further optimize by maintaining a simple optimization status for register contents.
	 We record whether ReceiverResultReg contains the receiver or an indirect temp vector
	 and merge this status at control-flow joins."