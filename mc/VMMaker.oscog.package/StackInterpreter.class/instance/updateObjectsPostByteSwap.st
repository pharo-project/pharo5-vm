image save/restore
updateObjectsPostByteSwap
	"Byte-swap the words of all bytes objects in the image, including Strings, ByteArrays,
	 and CompiledMethods. This returns these objects to their original byte ordering
	 after blindly byte-swapping the entire image. For compiled  methods, byte-swap
	 only their bytecodes part. Ensure floats are in platform-order."
	| swapFloatWords |
	swapFloatWords := objectMemory vmEndianness ~= imageFloatsBigEndian.
	self assert: ClassFloatCompactIndex ~= 0.
	objectMemory allObjectsDo:
		[:oop| | fmt wordAddr methodHeader temp |
		fmt := objectMemory formatOf: oop.
		 fmt >= self firstByteFormat ifTrue: "oop contains bytes"
			[wordAddr := oop + BaseHeaderSize.
			fmt >= self firstCompiledMethodFormat ifTrue: "compiled method; start after methodHeader and literals"
				[methodHeader := self longAt: oop + BaseHeaderSize.
				 wordAddr := wordAddr + (((self literalCountOfHeader: methodHeader) + LiteralStart) * BytesPerWord)].
			objectMemory reverseBytesFrom: wordAddr to: oop + (objectMemory sizeBitsOf: oop)].
		 fmt = self firstLongFormat ifTrue: "Bitmap, Float etc"
			[(swapFloatWords
			  and: [(objectMemory compactClassIndexOf: oop) = ClassFloatCompactIndex])
				ifTrue:
					[temp := self longAt: oop + BaseHeaderSize.
					 self longAt: oop + BaseHeaderSize put: (self longAt: oop + BaseHeaderSize + 4).
					 self longAt: oop + BaseHeaderSize + 4 put: temp]
				ifFalse:
					[BytesPerWord = 8 ifTrue: "Object contains 32-bit half-words packed into 64-bit machine words."
						[wordAddr := oop + BaseHeaderSize.
						 objectMemory reverseWordsFrom: wordAddr to: oop + (objectMemory sizeBitsOf: oop)]]]]