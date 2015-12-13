testing
allocateMemoryOfSize: limit
	<doNotGenerate>
	memory := (self endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: limit // 4