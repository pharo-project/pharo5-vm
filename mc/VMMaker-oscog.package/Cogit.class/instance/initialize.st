initialization
initialize
	cogMethodSurrogateClass := BytesPerWord = 4
											ifTrue: [CogMethodSurrogate32]
											ifFalse: [CogMethodSurrogate64].
	cogBlockMethodSurrogateClass := BytesPerWord = 4
											ifTrue: [CogBlockMethodSurrogate32]
											ifFalse: [CogBlockMethodSurrogate64]