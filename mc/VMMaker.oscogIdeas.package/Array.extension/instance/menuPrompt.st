*VMMaker-interpreter simulator
menuPrompt
	^String streamContents:
		[:s|
		s space; nextPut: $(.
		self do: [:address| s nextPutAll: address hex]
			separatedBy: [s space].
		s nextPut: $)]