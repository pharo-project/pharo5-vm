marshalling
allocaLiesSoUseGetsp
	"At least one alloca implementation does not answer the actual top of stack.
	 If so we need to get the actual stack pointer.  Answer whether this is necessary."
	<cmacro: '() ALLOCA_LIES_SO_USE_GETSP'>
	^false