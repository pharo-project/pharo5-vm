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
			[wordAddr := oop + objectMemory baseHeaderSize.
			fmt >= self firstCompiledMethodFormat ifTrue: "compiled method; start after methodHeader and literals"
				[methodHeader := objectMemory longAt: oop + objectMemory baseHeaderSize.
				 wordAddr := wordAddr + (((objectMemory literalCountOfMethodHeader: methodHeader) + LiteralStart) * objectMemory bytesPerOop)].
			objectMemory reverseBytesFrom: wordAddr to: oop + (objectMemory sizeBitsOf: oop)].
		 fmt = self firstLongFormat ifTrue: "Bitmap, Float etc"
			[(swapFloatWords
			  and: [(objectMemory compactClassIndexOf: oop) = ClassFloatCompactIndex])
				ifTrue:
					[temp := objectMemory longAt: oop + objectMemory baseHeaderSize.
					 objectMemory longAt: oop + objectMemory baseHeaderSize put: (self longAt: oop + objectMemory baseHeaderSize + 4).
					 objectMemory longAt: oop + objectMemory baseHeaderSize + 4 put: temp]
				ifFalse:
					[(objectMemory hasSpurMemoryManagerAPI not
					  and: [objectMemory wordSize = 8]) ifTrue: "Object contains 32-bit half-words packed into 64-bit machine words."
						[wordAddr := oop + objectMemory baseHeaderSize.
						 objectMemory reverseWordsFrom: wordAddr to: oop + (objectMemory sizeBitsOf: oop)]]]]