contexts
pop: nItems thenPushBool: trueOrFalse
	"A few places pop a few items off the stack and then push a boolean. Make it convenient"
	| sp |
	self longAt: (sp := stackPointer - ((nItems - 1) * self wordSize))
		put:(trueOrFalse ifTrue: [trueObj] ifFalse: [falseObj]).
	stackPointer := sp