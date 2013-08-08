simulation only
surrogateClass
	^BytesPerWord = 4
		ifTrue: [CogStackPageSurrogate32]
		ifFalse: [CogStackPageSurrogate64]