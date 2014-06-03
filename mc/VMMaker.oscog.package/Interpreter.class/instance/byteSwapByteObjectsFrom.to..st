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
							wordAddr := oop + BaseHeaderSize.
							fmt >= 12
								ifTrue: ["compiled method; start after methodHeader and literals"
									methodHeader := self longAt: oop + BaseHeaderSize.
									wordAddr := wordAddr + BytesPerWord + ((methodHeader >> 10 bitAnd: 255) * BytesPerWord)].
							self reverseBytesFrom: wordAddr to: oop + (self sizeBitsOf: oop)].
					(fmt = 6 and: [BytesPerWord = 8])
						ifTrue: ["Object contains 32-bit half-words packed into 64-bit machine words."
							wordAddr := oop + BaseHeaderSize.
							self reverseWordsFrom: wordAddr to: oop + (self sizeBitsOf: oop)]].
			oop := self objectAfter: oop]