marshalling
allocaLiesSoSetSpBeforeCall
	"At least one alloca implementation does not answer the actual top of stack.
	 If so we need to reset the actual stack pointer just before the call.
	Answer whether this is necessary."
	<cmacro: '() ALLOCA_LIES_SO_SETSP_BEFORE_CALL'>
	^false