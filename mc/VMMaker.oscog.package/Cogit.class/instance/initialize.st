initialization
initialize
	| wordSize |
	wordSize := self class objectMemoryClass wordSize.
	cogMethodSurrogateClass := NewspeakVM
									ifTrue:
										[wordSize = 4
											ifTrue: [NewspeakCogMethodSurrogate32]
											ifFalse: [NewspeakCogMethodSurrogate64]]
									ifFalse:
										[wordSize = 4
											ifTrue: [CogMethodSurrogate32]
											ifFalse: [CogMethodSurrogate64]].
	cogBlockMethodSurrogateClass := wordSize = 4
											ifTrue: [CogBlockMethodSurrogate32]
											ifFalse: [CogBlockMethodSurrogate64].
	nsSendCacheSurrogateClass := wordSize = 4
											ifTrue: [NSSendCacheSurrogate32]
											ifFalse: [NSSendCacheSurrogate64].