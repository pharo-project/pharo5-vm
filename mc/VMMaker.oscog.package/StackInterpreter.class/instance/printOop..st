debug printing
printOop: oop
	| cls fmt lastIndex startIP bytecodesPerLine column |
	<inline: false>
	(objectMemory isImmediate: oop) ifTrue:
		[^self shortPrintOop: oop].
	self printHex: oop.
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^self print: ((oop bitAnd: objectMemory allocationUnit - 1) ~= 0
						ifTrue: [' is misaligned']
						ifFalse: [self whereIs: oop]); cr].
	(objectMemory isFreeObject: oop) ifTrue:
		[^self print: ' is a free chunk of size '; printNum: (objectMemory sizeOfFree: oop); cr].
	(objectMemory isForwarded: oop) ifTrue:
		[^self
			print: ' is a forwarded object to '; printHex: (objectMemory followForwarded: oop);
			print: ' of slot size '; printNum: (objectMemory numSlotsOfAny: oop); cr].
	self print: ': a(n) '.
	self printNameOfClass: (cls := objectMemory fetchClassOfNonImm: oop) count: 5.
	cls = (objectMemory splObj: ClassFloat) ifTrue:
		[^self cr; printFloat: (self dbgFloatValueOf: oop); cr].
	fmt := objectMemory formatOf: oop.
	fmt > objectMemory lastPointerFormat ifTrue:
		[self print: ' nbytes '; printNum: (objectMemory byteLengthOf: oop)].
	self cr.
	(fmt between: objectMemory firstLongFormat and: objectMemory firstCompiledMethodFormat - 1) ifTrue:
		["This will answer false if splObj: ClassAlien is nilObject"
		 (self is: oop KindOfClass: (objectMemory splObj: ClassAlien)) ifTrue:
			[self print: ' datasize '; printNum: (self sizeOfAlienData: oop).
			self print: ((self isIndirectAlien: oop)
							ifTrue: [' indirect @ ']
							ifFalse:
								[(self isPointerAlien: oop)
									ifTrue: [' pointer @ ']
									ifFalse: [' direct @ ']]).
			 ^self printHex: (self startOfAlienData: oop) asUnsignedInteger; cr].
		 (objectMemory isWords: oop) ifTrue:
			[lastIndex := 64 min: ((objectMemory byteLengthOf: oop) / BytesPerWord).
			 lastIndex > 0 ifTrue:
				[1 to: lastIndex do:
					[:index|
					self space; printHex: (objectMemory fetchLong32: index - 1 ofObject: oop).
					(index \\ self elementsPerPrintOopLine) = 0 ifTrue:
						[self cr]].
				(lastIndex \\ self elementsPerPrintOopLine) = 0 ifFalse:
					[self cr]].
			^self].
		^self printStringOf: oop; cr].
	"this is nonsense.  apologies."
	startIP := (objectMemory lastPointerOf: oop) + BytesPerOop - objectMemory baseHeaderSize / BytesPerOop.
	lastIndex := 256 min: startIP.
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:index|
			self cCode: [self printHex: (objectMemory fetchPointer: index - 1 ofObject: oop); space]
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