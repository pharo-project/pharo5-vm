internal interpreter access
pop: nItems thenPushBool: trueOrFalse
	"In the StackInterpreter stacks grow down."
	| sp |
	<inline: true>
	<var: #sp type: #'char *'>
	stackPages
		longAt: (sp := stackPointer + ((nItems - 1) * BytesPerWord))
		put: (objectMemory booleanObjectOf: trueOrFalse).
	stackPointer := sp