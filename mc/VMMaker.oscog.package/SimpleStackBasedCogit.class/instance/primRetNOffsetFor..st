primitive generators
primRetNOffsetFor: nargs
	"Answer how many bytes to cut back the stack to remove the receiver
	 and arguments after an invocation of a primitive with nargs arguments. "
	^nargs + 1 * objectMemory wordSize