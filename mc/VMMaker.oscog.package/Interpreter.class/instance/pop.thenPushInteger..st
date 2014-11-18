contexts
pop: nItems thenPushInteger: integerVal
"lots of places pop a few items off the stack and then push an integer. MAke it convenient"
	| sp |
	self longAt: (sp := stackPointer - ((nItems - 1) * self wordSize)) put:(self integerObjectOf: integerVal).
	stackPointer := sp.
