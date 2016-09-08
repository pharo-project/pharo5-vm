image save/restore
byteSwapByteObjectsFrom: startOop to: stopAddr 
	"Byte-swap the words of all bytes objects in a range of the 
	image, including Strings, ByteArrays, and CompiledMethods. 
	This returns these objects to their original byte ordering 
	after blindly byte-swapping the entire image. For compiled 
	methods, byte-swap only their bytecodes part."
	| oop fmt wordAddr methodHeader |
	oop := startOop.
	[self oop: oop isLessThan: stopAddr]
		whileTrue: [(self isFreeObject: oop)
				ifFalse: [fmt := self formatOf: oop.
					fmt >= 8
						ifTrue: ["oop contains bytes"
							wordAddr := oop + self baseHeaderSize.
							fmt >= 12
								ifTrue: ["compiled method; start after methodHeader and literals"
									methodHeader := self longAt: oop + self baseHeaderSize.
									wordAddr := wordAddr + self wordSize + ((methodHeader >> 10 bitAnd: 255) * self wordSize)].
							self reverseBytesFrom: wordAddr to: oop + (self sizeBitsOf: oop)].
					(fmt = 6 and: [self wordSize = 8])
						ifTrue: ["Object contains 32-bit half-words packed into 64-bit machine words."
							wordAddr := oop + self baseHeaderSize.
							self reverseWordsFrom: wordAddr to: oop + (self sizeBitsOf: oop)]].
			oop := self objectAfter: oop]