documentation
interpreterMachineCodeTransitions
	"The CoInterpreter only asks the Cog compiler to generate machine-code methods
	 when a bytecoded method has been found in the cache, or block value has tried to
	 invoke a block in the method two times consecutively.  This prevents the compiler
	 being asked to compile an infrequenttly used method.

	I would like the following to be true, but it isn't.  The interpreter *does* invoke
	machine-code primitives that may context switch.

	 The CoInterpreter will only activate a Cog method that doesn't have a primitive
	 (this does not mean it won't invoke a Cog block method; it just does so through the
	 interpreted block value primitives).  This is to avoid serious complications with the
	 process switch primitives.  The CoInterpreter needs to know if it should push the
	 instructionPointer or save it in frameSavedIP and substitute ceReturtnToInterpreterPC
	 as the pushed instruction pointer.  The process switch primitives need to know if
	 they were called from the interpreter or from machine-code to know how to continue.

	 If a process switch primitive has been invoked from the interpreter and switches to
	 a process suspended in an interpreted method it can return to the interpreter.  In both
	 cases switching to a process in machine-code the primtiive can continue via the
	 ceEnterCogCodeXXX enilopmart(s).  But if in machine-code and switching to a process
	 in the interpreter it must longjmp to the interpreter.  So the process-switch primtiives
	 need to know whether they werer invoked from the interpreter or not.

	 If the process-switch primitives are allowed to be invoked from the interpreter via a
	 machine-code method then, in the immortal words of Robert Fripp, ``affairs stand a
	 good chance of getting severely out of hand...'' (The Guitar Handbook, Ralph Denyer,
	 p 114, Pan Books).  The VM now has to longjmp not only if invoked from machine code
	 and switching to the interpreter but if invoked from the interpreter via machine code
	 and switching to the interpreter.  The issue is that it is difficult to discover from within
	 a primitive whether the primitive call is from machine code, as it should be; it isn't a
	 concern of the primitive.  Hence KISS says ``no machine-code invocation of primitives
	 from the interpreter''."