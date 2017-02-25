primitive generators
genPrimReturn
	"Generate a return that cuts back the stack to remove the receiver
	 and arguments after an invocation of a primitive with nargs arguments.
	 This is similar to a Pascal calling convention."
	<inline: true>
	^self RetN: methodOrBlockNumArgs + 1 * objectMemory wordSize