initialization
initialize
	super initialize.
	cogMethodSurrogateClass := objectMemory wordSize = 4
											ifTrue: [CogSistaMethodSurrogate32]
											ifFalse: [CogSistaMethodSurrogate64]