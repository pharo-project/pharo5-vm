internal interpreter access
pop: nItems thenPushFloat: f
	"In the StackInterpreter stacks grow down."
	| sp |
	<inline: true>
	<var: #f type: #double>
	<var: #sp type: #'char *'>
	stackPages
		longAt: (sp := stackPointer + ((nItems - 1) * BytesPerWord))
		put: (self floatObjectOf: f).
	stackPointer := sp