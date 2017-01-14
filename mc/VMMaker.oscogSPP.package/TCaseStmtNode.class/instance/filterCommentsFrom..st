private
filterCommentsFrom: aString
	"elide any /* comment */ occurrences from aString."
	| i |
	i := aString indexOfSubCollection: '/*'startingAt: 1 ifAbsent: [^aString].
	^(aString copyFrom: 1 to: i - 1),
	  (self filterCommentsFrom:
		(aString
			copyFrom: (aString indexOfSubCollection: '*/' startingAt: i + 2) + 2
			to: aString size))