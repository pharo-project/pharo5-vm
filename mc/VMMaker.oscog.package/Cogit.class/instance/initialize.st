initialization
initialize
	cogMethodSurrogateClass := NewspeakVM
									ifTrue:
										[BytesPerWord = 4
											ifTrue: [NewspeakCogMethodSurrogate32]
											ifFalse: [NewspeakCogMethodSurrogate64]]
									ifFalse:
										[BytesPerWord = 4
											ifTrue: [CogMethodSurrogate32]
											ifFalse: [CogMethodSurrogate64]].
	cogBlockMethodSurrogateClass := BytesPerWord = 4
											ifTrue: [CogBlockMethodSurrogate32]
											ifFalse: [CogBlockMethodSurrogate64]