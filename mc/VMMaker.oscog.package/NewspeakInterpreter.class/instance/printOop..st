debug printing
printOop: oop
	| cls fmt lastIndex startIP bytecodesPerLine |
	<inline: false>
	self printHex: oop.
	(self isIntegerObject: oop) ifTrue:
		[^self
			cCode: 'printf("=%ld\n", (long)integerValueOf(oop))'
			inSmalltalk: [self print: (self shortPrint: oop); cr]].
	(oop between: self startOfMemory and: freeBlock) ifFalse:
		[self printHex: oop; print: ' is not on the heap'; cr.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'; cr.
		 ^nil].
	(self isFreeObject: oop) ifTrue:
		[self print: ' free chunk of size '; printNum: (self sizeOfFree: oop); cr.
		 ^nil].
	self print: ': a(n) '.
	self printNameOfClass: (cls := self fetchClassOfNonImm: oop) count: 5.
	cls = (self splObj: ClassFloat) ifTrue:
		[self cr; printFloat: (self dbgFloatValueOf: oop); cr.
		 ^nil].
	fmt := self formatOf: oop.
	fmt > 4 ifTrue:
		[self print: ' nbytes '; printNum: (self byteSizeOf: oop)].
	self cr.
	(fmt > 4 and: [fmt < 12]) ifTrue:
		[(self isWords: oop) ifTrue:
			[lastIndex := 64 min: ((self byteSizeOf: oop) / BytesPerWord).
			 lastIndex > 0 ifTrue:
				[1 to: lastIndex do:
					[:index|
					self space; printHex: (self fetchLong32: index - 1 ofObject: oop).
					(index \\ self elementsPerPrintOopLine) = 0 ifTrue:
						[self cr]].
				(lastIndex \\ self elementsPerPrintOopLine) = 0 ifFalse:
					[self cr]].
			^nil].
		^self printStringOf: oop; cr].
	lastIndex := 64 min: (startIP := (self lastPointerOf: oop) / BytesPerWord).
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:index|
			self cCode: 'printHex(fetchPointerofObject(index - 1, oop)); putchar('' '')'
				inSmalltalk: [self space; printHex: (self fetchPointer: index - 1 ofObject: oop); space.
							 self print: (self shortPrint: (self fetchPointer: index - 1 ofObject: oop))].
			(index \\ self elementsPerPrintOopLine) = 0 ifTrue:
				[self cr]].
		(lastIndex \\ self elementsPerPrintOopLine) = 0 ifFalse:
			[self cr]].
	(self isCompiledMethod: oop)
		ifFalse:
			[startIP > 64 ifTrue: [self print: '...'; cr]]
		ifTrue:
			[startIP := startIP * BytesPerWord + 1.
			 lastIndex := self lengthOf: oop.
			 lastIndex - startIP > 100 ifTrue:
				[lastIndex := startIP + 100].
			 bytecodesPerLine := 10.
			 startIP to: lastIndex do:
				[:index| | byte |
				byte := self fetchByte: index - 1 ofObject: oop.
				self cCode: 'printf(" %02x/%-3d", byte,byte)'
					inSmalltalk: [self space; print: (byte radix: 16); printChar: $/; printNum: byte].
				((index - startIP + 1) \\ bytecodesPerLine) = 0 ifTrue:
					[self cr]].
			((lastIndex - startIP + 1) \\ bytecodesPerLine) = 0 ifFalse:
				[self cr]]