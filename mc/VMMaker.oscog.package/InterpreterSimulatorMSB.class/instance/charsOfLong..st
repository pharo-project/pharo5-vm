debug support
charsOfLong: long
	^ (self wordSize to: 1 by: -1) collect:
		[:i | ((long digitAt: i) between: 14 and: 126)
					ifTrue: [(long digitAt: i) asCharacter]
					ifFalse: [$?]]