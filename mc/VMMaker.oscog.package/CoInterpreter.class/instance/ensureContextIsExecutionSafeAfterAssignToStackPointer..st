frame access
ensureContextIsExecutionSafeAfterAssignToStackPointer: aContext
	"Safety to give the JIT lattitude in calling convention.  Conceptually, returning
	 a value to a context involves pushing that value onto the stack.  This is used
	 in Squeak methods such as ContextPart>>jump
		jump
			| top |
			thisContext sender push: nil.
			stackp = 0 ifTrue: [self stepToSendOrReturn].
			stackp = 0 ifTrue: [self push: nil].
			top := self pop.
			thisContext privSender: self.
			^top
	 Here jump may pop the value of a temporary variable off the stack which will,
	 conceptually and, in the interpreter, actually, get pushed back on return.  But
	 if the JIT is mapping the stack to registers disaster may ensue since the value
	 may not get pushed to the stack and code may access an invalid value (e.g. a pc).

	 The solution is to fall back on the interpreter.  If the stack pointer is changed we
	 also ensure the pc is a bytecode pc (+ive) which will cause makeBaseFrameFor:
	 to create an interpreter frame if the context is executed again."
	<inline: false>
	self ensureContextHasBytecodePC: aContext