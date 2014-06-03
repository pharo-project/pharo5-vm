frame access
ensureContextIsExecutionSafeAfterAssignToStackPointer: aContext
	"Safety to give the JIT lattitude in calling convention.  A noop in the interpreter.
	 See subclass implementation(s) for explanation."