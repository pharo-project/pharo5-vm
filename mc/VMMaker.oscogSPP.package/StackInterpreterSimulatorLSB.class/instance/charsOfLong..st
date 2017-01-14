debug support
charsOfLong: long
	^ (1 to: objectMemory wordSize) collect:
		[:i | ((long digitAt: i) between: 14 and: 126)
					ifTrue: [(long digitAt: i) asCharacter]
					ifFalse: [$?]]