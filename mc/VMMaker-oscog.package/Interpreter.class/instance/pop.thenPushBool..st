contexts
pop: nItems thenPushBool: trueOrFalse
	"A few places pop a few items off the stack and then push a boolean. Make it convenient"
	| sp |
	self longAt: (sp := stackPointer - ((nItems - 1) * BytesPerWord))
		put:(trueOrFalse ifTrue: [trueObj] ifFalse: [falseObj]).
	stackPointer := sp