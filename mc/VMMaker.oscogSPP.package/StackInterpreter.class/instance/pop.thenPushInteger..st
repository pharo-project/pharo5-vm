internal interpreter access
pop: nItems thenPushInteger: integerVal
	"lots of places pop a few items off the stack and then push an integer. Make it convenient.
	 In the StackInterpreter stacks grow down."
	| sp |
	<var: #sp type: #'char *'>
	stackPages
		longAt: (sp := stackPointer + ((nItems - 1) * objectMemory wordSize))
		put: (objectMemory integerObjectOf: integerVal).
	stackPointer := sp