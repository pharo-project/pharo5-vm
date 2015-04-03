initialization
initialize
	super initialize.
	cogMethodSurrogateClass := (objectMemory ifNil: [self class objectMemoryClass]) wordSize = 4
										ifTrue: [CogSistaMethodSurrogate32]
										ifFalse: [CogSistaMethodSurrogate64]