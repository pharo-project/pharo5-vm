C code generation
printSingleComment: aString on: aStream indent: indent tabWidth: tabWidth lineBreak: lineBreak
	"Shameless hack of ParseNode>>printSingleComment:on:indent: for formatting comments."
	| readStream position wordStream |
	readStream := ReadStream on: aString.
	position := indent * tabWidth.
	wordStream := WriteStream on: (String new: 16).
	[readStream atEnd] whileFalse:
		[| word wordWidth lastChar |
		wordStream reset.
		wordWidth := 0.
		[(readStream peekFor: Character space) 
		 or: [readStream peekFor: Character tab]] whileTrue.
		[readStream atEnd
		 or: [(lastChar := readStream next) = Character cr
			 or: [lastChar = Character space]]] whileFalse:
			[wordWidth := wordWidth + 1.
			 wordStream nextPut: lastChar].
		word := wordStream contents.
		position := position + wordWidth.
		position > lineBreak
			ifTrue:
				[aStream skip: -1; crtab: indent.
				position := indent * tabWidth + wordWidth + 1.
				lastChar = Character cr ifTrue:
					[[readStream peekFor: Character tab] whileTrue].
				word isEmpty ifFalse:
					[aStream nextPutAll: word; space]]
			ifFalse:
				[aStream nextPutAll: word.
				readStream atEnd ifFalse:
					[position := position + 1.
					aStream space].
				lastChar = Character cr ifTrue:
					[aStream skip: -1; crtab: indent.
					position := indent * tabWidth.
					[readStream peekFor: Character tab] whileTrue]]]