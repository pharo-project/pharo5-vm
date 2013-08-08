debug printing
longPrintOop: oop
	<api>
	| class fmt lastIndex startIP bytecodesPerLine column |
	((objectMemory isIntegerObject: oop)
	 or: [(oop between: objectMemory startOfMemory and: objectMemory freeStart) not
	 or: [(oop bitAnd: (BytesPerWord - 1)) ~= 0
	 or: [(objectMemory isFreeObject: oop)]]]) ifTrue:
		[^self printOop: oop].
	class := objectMemory fetchClassOfNonInt: oop.
	self printHex: oop;
		print: ': a(n) '; printNameOfClass: class count: 5;
		print: ' ('; printHex: class; print: ')'.
	fmt := objectMemory formatOf: oop.
	fmt > 4 ifTrue:
		[self print: ' nbytes '; printNum: (objectMemory byteLengthOf: oop)].
	objectMemory printHeaderTypeOf: oop.
	self cr.
	(fmt between: 5 and: 11) ifTrue:
		[^self].
	lastIndex := 256 min: (startIP := (objectMemory lastPointerOf: oop) / BytesPerWord).
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:i| | fieldOop |
			fieldOop := objectMemory fetchPointer: i - 1 ofObject: oop.
			self space; printNum: i - 1; space; printHex: fieldOop; space.
			(i = 1 and: [objectMemory isCompiledMethod: oop])
				ifTrue: [self printMethodHeaderOop: fieldOop]
				ifFalse: [self printOopShort: fieldOop].
			self cr]].
	(objectMemory isCompiledMethod: oop)
		ifFalse:
			[startIP > 64 ifTrue: [self print: '...'; cr]]
		ifTrue:
			[startIP := startIP * BytesPerWord + 1.
			 lastIndex := objectMemory lengthOf: oop.
			 lastIndex - startIP > 100 ifTrue:
				[lastIndex := startIP + 100].
			 bytecodesPerLine := 8.
			 column := 1.
			 startIP to: lastIndex do:
				[:index| | byte |
				column = 1 ifTrue:
					[self cCode: 'printf("0x%08x: ", oop+BaseHeaderSize+index-1)'
						inSmalltalk: [self print: (oop+BaseHeaderSize+index-1) hex; print: ': ']].
				byte := objectMemory fetchByte: index - 1 ofObject: oop.
				self cCode: 'printf(" %02x/%-3d", byte,byte)'
					inSmalltalk: [self space; print: (byte radix: 16); printChar: $/; printNum: byte].
				column := column + 1.
				column > bytecodesPerLine ifTrue:
					[column := 1. self cr]].
			column = 1 ifFalse:
				[self cr]]