simulation only
characterObjectOf: characterCode
	^(characterCode between: 0 and: 255) ifTrue:
		[characterCode asCharacter]