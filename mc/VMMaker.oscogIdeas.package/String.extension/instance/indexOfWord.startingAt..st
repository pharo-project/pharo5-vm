*VMMaker-translation support
indexOfWord: aSubString startingAt: startIndex
	| index |
	index := startIndex.
	[index <= self size] whileTrue:
		[index := self indexOfSubCollection: aSubString startingAt: index ifAbsent: [^0].
		 ((index = 1 or: [(self at: index - 1) isLetter not])
		  and: [index + aSubString size > self size
				or: [(self at: index + aSubString size) isAlphaNumeric not]]) ifTrue:
			[^index].
		 index := index + 1].
	^0