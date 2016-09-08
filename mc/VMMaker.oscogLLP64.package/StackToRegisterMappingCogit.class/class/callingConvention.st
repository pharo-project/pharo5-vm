documentation
callingConvention
	"The Smalltalk-to-Smalltalk calling convention aims to trade simplicity of compilation against
	 effectiveness of optimization.  Most Smalltalk methods, and certainly most performance-
	 critical primitives have two or less arguments.  So arranging that the receiver and up to two
	 args are in registers means that performance-critical primitives can access their arguments
	 in registers.  So if the argument count is <= numRegArgs nothing is passed on the stack and
	 everything is passed in ReceiverResultReg, Arg0Reg et al.  Above numRegArgs everything is
	 passed on the stack.

	 To save the CoInterpreter from change we shuffle the retpc and push the register args in
	 the prolog so that the frame format is unchanged by register args.  Also, the trampolines for
	 unlinked sends do the same, as does the code preceding an interpreter primitive.  It turns
	 out that this protocol is faster than always pushing arguments.  Comparing benchFib with the
	 shuffling protocol against an always-push protocol on a 2.66 GHz Core i7 (MacBook Pro) , the
	 shuffling protocol is 6.3% faster than the always push protocol.

	 Not shuffling the stack and pushing register arguments after frame build is faster yet again,
	 5.8% faster that the stack shuffle.  So it might be worth-while to change the CoInterpreter's
	 frame management to allow numArgs <= numRegArgs frames to push receiver and arguments
	 after saving the return pc.  This implies changes in stack-to-context mapping, GC,
	 interpreter-to-machine code frame conversion and no doubt else where.

	 Hence the calling convention is

		- if the number of arguments is less than or equal to numRegArgs then the receiver and
		  arguments are passed in registers.  numRegArgs is 1 for V3, and 2 for Spur.  The receiver
		  is passed in ReceiverResultReg, the first argument in Arg0Reg (esi on x86) and the second
		  argument (if numRegArgs = 2) in Arg1Reg (edi on x86).

		- if the number of arguments is greater than numRegArgs then the calling convention is as
		  for SimpleStackBasedCogIt; ReceiverResultReg contains the receiver, and the receiver and
		  arguments are all on the stack, receiver furthest from top-of-stack.  If the argument count
		  is > 2 then argument count is passed in SendNumArgsReg (for the benefit of the run-time
		  linking routines; it is ignored in linked sends).

		On return the result is in ReceiverResultReg.  The callee removes arguments from the stack
		(Pascal convention).

		Note that if a machine code method contains a call to an interpreter primitive it will push any
		register arguments (and if on a RISC, the return pc from the LinReg) on the stack before calling
		the primitive so that to the primitive the stack looks the same as it does in the interpreter.

		Within all machine code primitives except genPrimitiveClosureValue and genPrimitivePerform all
		arguments are taken from registers since no machine code primitive has more than numRegArgs
		arguments.  genPrimitiveClosureValue pushes its register arguments immedately only for laziness
		to be able to reuse SimpleStackBasedCogit's code.  genPrimitivePerform adjusts its arguments
		as required by special-purpose code.

		Within machine code methods with interpreter primitives the register arguments are pushed
		before calling the interpreter primitive.  In normal methods and if not already done so in primitive
		code, the register arguments are pushed during frame build.  If a method is compiled frameless
		it will access its arguments in registers."