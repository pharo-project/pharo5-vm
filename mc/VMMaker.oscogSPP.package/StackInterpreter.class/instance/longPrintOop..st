debug printing
longPrintOop: oop
	<api>
	| fmt lastIndex startIP bytecodesPerLine column |
	((objectMemory isImmediate: oop)
	 or: [(objectMemory addressCouldBeObj: oop) not
	 or: [(oop bitAnd: objectMemory allocationUnit - 1) ~= 0
	 or: [(objectMemory isFreeObject: oop)
	 or: [objectMemory isForwarded: oop]]]]) ifTrue:
		[self printOop: oop.
		 ^self].
	self printHex: oop.
	(objectMemory fetchClassOfNonImm: oop)
		ifNil: [self print: ' has a nil class!!']
		ifNotNil: [:class|
			self print: ': a(n) '; printNameOfClass: class count: 5;
				print: ' ('.
			objectMemory hasSpurMemoryManagerAPI ifTrue:
				[self printHexnp: (objectMemory compactClassIndexOf: oop); print: '=>'].
			self printHexnp: class; print: ')'].
	fmt := objectMemory formatOf: oop.
	self print: ' format '; printHexnp: fmt.
	fmt > objectMemory lastPointerFormat
		ifTrue: [self print: ' nbytes '; printNum: (objectMemory numBytesOf: oop)]
		ifFalse: [(objectMemory isIndexableFormat: fmt) ifTrue:
					[| len |
					len := objectMemory lengthOf: oop.
					self print: ' size '; printNum: len - (objectMemory fixedFieldsOf: oop format: fmt length: len)]].
	objectMemory printHeaderTypeOf: oop.
	self print: ' hash '; printHexnp: (objectMemory rawHashBitsOf: oop).
	self cr.
	(fmt between: objectMemory firstByteFormat and: objectMemory firstCompiledMethodFormat - 1) ifTrue:
		[^self printStringOf: oop; cr].
	(fmt between: objectMemory firstLongFormat and: objectMemory firstByteFormat - 1) ifTrue:
		[0 to: ((objectMemory num32BitUnitsOf: oop) min: 256) - 1 do:
			[:i| | fieldOop |
			fieldOop := objectMemory fetchLong32: i ofObject: oop.
			self space; printNum: i; space; printHex: fieldOop; space; cr].
		 ^self].
	"this is nonsense.  apologies."
	startIP := (objectMemory lastPointerOf: oop) + objectMemory bytesPerOop - objectMemory baseHeaderSize / objectMemory bytesPerOop.
	lastIndex := 256 min: startIP.
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:i| | fieldOop |
			fieldOop := objectMemory fetchPointer: i - 1 ofObject: oop.
			self space; printNum: i - 1; space; printHex: fieldOop; space.
			(i = 1 and: [objectMemory isCompiledMethod: oop])
				ifTrue: [self printMethodHeaderOop: fieldOop]
				ifFalse: [self cCode: [self printOopShort: fieldOop]
							inSmalltalk: [self print: (self shortPrint: fieldOop)]].
			self cr]].
	(objectMemory isCompiledMethod: oop)
		ifFalse:
			[startIP > lastIndex ifTrue: [self print: '...'; cr]]
		ifTrue:
			[startIP := startIP * objectMemory wordSize + 1.
			 lastIndex := objectMemory lengthOf: oop.
			 lastIndex - startIP > 100 ifTrue:
				[lastIndex := startIP + 100].
			 bytecodesPerLine := 8.
			 column := 1.
			 startIP to: lastIndex do:
				[:index| | byte |
				column = 1 ifTrue:
					[self cCode: 'printf("0x%08" PRIxSQPTR ": ", (usqIntptr_t)(oop+BaseHeaderSize+index-1))'
						inSmalltalk: [self print: (oop+objectMemory baseHeaderSize+index-1) hex; print: ': ']].
				byte := objectMemory fetchByte: index - 1 ofObject: oop.
				self cCode: 'printf(" %02x/%-3d", (int)byte,(int)byte)'
					inSmalltalk: [self space; print: (byte radix: 16); printChar: $/; printNum: byte].
				column := column + 1.
				column > bytecodesPerLine ifTrue:
					[column := 1. self cr]].
			column = 1 ifFalse:
				[self cr]]