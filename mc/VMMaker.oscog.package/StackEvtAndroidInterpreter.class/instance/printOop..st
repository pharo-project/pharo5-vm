debug printing
printOop: oop
	| cls fmt lastIndex startIP bytecodesPerLine |
	<inline: false>
	self printHex: oop.
	(objectMemory isIntegerObject: oop) ifTrue:
		[^self
			cCode: 'jprintf("=%ld\n", integerValueOf(oop))'
			inSmalltalk: [self print: (self shortPrint: oop); cr]].
	(oop between: objectMemory startOfMemory and: objectMemory freeStart) ifFalse:
		[self printHex: oop; print: ' is not on the heap'; cr.
		 ^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[self printHex: oop; print: ' is misaligned'; cr.
		 ^nil].
	(objectMemory isFreeObject: oop) ifTrue:
		[self print: ' free chunk of size '; printNum: (objectMemory sizeOfFree: oop); cr.
		 ^nil].
	self print: ': a(n) '.
	self printNameOfClass: (cls := objectMemory fetchClassOfNonInt: oop) count: 5.
	cls = (objectMemory splObj: ClassFloat) ifTrue:
		[self cr; printFloat: (self dbgFloatValueOf: oop); cr.
		 ^nil].
	fmt := objectMemory formatOf: oop.
	fmt > 4 ifTrue:
		[self print: ' nbytes '; printNum: (objectMemory byteSizeOf: oop)].
	self cr.
	(fmt > 4 and: [fmt < 12]) ifTrue:
		["This will answer false if splObj: ClassAlien is nilObject"
		 (self is: oop KindOfClass: (objectMemory splObj: ClassAlien)) ifTrue:
			[self print: ' datasize '; printNum: (self sizeOfAlienData: oop).
			self print: ((self isIndirectAlien: oop)
							ifTrue: [' indirect @ ']
							ifFalse:
								[(self isPointerAlien: oop)
									ifTrue: [' pointer @ ']
									ifFalse: [' direct @ ']]).
			 self printHex: (self startOfAlienData: oop); cr.
			 ^nil].
		 (objectMemory isWords: oop) ifTrue:
			[lastIndex := 64 min: ((objectMemory byteSizeOf: oop) / BytesPerWord).
			 lastIndex > 0 ifTrue:
				[1 to: lastIndex do:
					[:index|
					self space; printHex: (objectMemory fetchLong32: index - 1 ofObject: oop).
					(index \\ self elementsPerPrintOopLine) = 0 ifTrue:
						[self cr]].
				(lastIndex \\ self elementsPerPrintOopLine) = 0 ifFalse:
					[self cr]].
			^nil].
		^self printStringOf: oop; cr].
	lastIndex := 64 min: (startIP := (objectMemory lastPointerOf: oop) / BytesPerWord).
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:index|
			self cCode: 'printHex(fetchPointerofObject(index - 1, oop)); putchar('' '')'
				inSmalltalk: [self space; printHex: (objectMemory fetchPointer: index - 1 ofObject: oop); space.
							 self print: (self shortPrint: (objectMemory fetchPointer: index - 1 ofObject: oop))].
			(index \\ self elementsPerPrintOopLine) = 0 ifTrue:
				[self cr]].
		(lastIndex \\ self elementsPerPrintOopLine) = 0 ifFalse:
			[self cr]].
	(objectMemory isCompiledMethod: oop)
		ifFalse:
			[startIP > 64 ifTrue: [self print: '...'; cr]]
		ifTrue:
			[startIP := startIP * BytesPerWord + 1.
			 lastIndex := objectMemory lengthOf: oop.
			 lastIndex - startIP > 100 ifTrue:
				[lastIndex := startIP + 100].
			 bytecodesPerLine := 10.
			 startIP to: lastIndex do:
				[:index| | byte |
				byte := objectMemory fetchByte: index - 1 ofObject: oop.
				self cCode: 'jprintf(" %02x/%-3d", byte,byte)'
					inSmalltalk: [self space; print: (byte radix: 16); printChar: $/; printNum: byte].
				((index - startIP + 1) \\ bytecodesPerLine) = 0 ifTrue:
					[self cr]].
			((lastIndex - startIP + 1) \\ bytecodesPerLine) = 0 ifFalse:
				[self cr]]