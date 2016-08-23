image segment in/out
byteSwapByteObjectsFrom: startOop to: stopAddr flipFloatsIf: flipFloatWords
	"Byte-swap the words of all bytes objects in a range of the 
	image, including Strings, ByteArrays, and CompiledMethods. 
	This returns these objects to their original byte ordering 
	after blindly byte-swapping the entire image. For compiled 
	methods, byte-swap only their bytecodes part.  For Floats
	swap their most and least significant words if required."
	| oop fmt temp wordAddr |
	oop := startOop.
	[self oop: oop isLessThan: stopAddr] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[fmt := self formatOf: oop.
			fmt >= self firstByteFormat ifTrue:
				["oop contains bytes; unswap"
				wordAddr := oop + self baseHeaderSize.
				fmt >= self firstCompiledMethodFormat ifTrue: "compiled method; start after methodHeader and literals"
					[wordAddr := wordAddr + ((self literalCountOf: oop) + LiteralStart * self bytesPerOop)].
				self reverseBytesFrom: wordAddr to: oop + (self sizeBitsOf: oop)].
			fmt = self firstLongFormat  ifTrue: "Bitmap, Float etc"
				[(self compactClassIndexOf: oop) = ClassFloatCompactIndex
					ifTrue:
						[flipFloatWords ifTrue:
							[temp := self longAt: oop + self baseHeaderSize.
							 self longAt: oop + self baseHeaderSize put: (self longAt: oop + self baseHeaderSize + 4).
							 self longAt: oop + self baseHeaderSize + 4 put: temp]]
					ifFalse:
						[self wordSize = 8 ifTrue:
							["Object contains 32-bit half-words packed into 64-bit machine words."
							wordAddr := oop + self baseHeaderSize.
							self reverseWordsFrom: wordAddr to: oop + (self sizeBitsOf: oop)]]]].
			oop := self objectAfter: oop]