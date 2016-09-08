debug printing
printStringOf: oop
	| fmt len cnt max i |
	<inline: false>
	(objectMemory isImmediate: oop) ifTrue:
		[^self].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self].
	fmt := objectMemory formatOf: oop.
	fmt < objectMemory firstByteFormat ifTrue: [^self].

	cnt := (max := 128) min: (len := objectMemory lengthOf: oop).
	i := 0.

	((objectMemory is: oop
		  instanceOf: (objectMemory splObj: ClassByteArray)
		  compactClassIndex: classByteArrayCompactIndex)
	or: [(objectMemory isLargeIntegerInstance: oop)])
		ifTrue:
			[[i < cnt] whileTrue:
				[self printHex: (objectMemory fetchByte: i ofObject: oop).
				 i := i + 1]]
		ifFalse:
			[[i < cnt] whileTrue:
				[self cCode:
						[(objectMemory fetchByte: i ofObject: oop) = 13 "Character cr asInteger" ifTrue:
							[self print: '<CR>'.
							 i + 1 < len ifTrue:
								[self print: '...'].
							 ^self]].
				 self printChar: (objectMemory fetchByte: i ofObject: oop).
				 i := i + 1]].
	len > max ifTrue:
		[self print: '...'].
	self flush