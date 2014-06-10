initialization
initialize
	super initialize.
	cogMethodSurrogateClass := BytesPerWord = 4
											ifTrue: [CogSistaMethodSurrogate32]
											ifFalse: [CogSistaMethodSurrogate64]