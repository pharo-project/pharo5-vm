simulation
allocateMemoryOfSize: limit
	<doNotGenerate>
	self setMemoryLimit: limit.
	memory := (self endianness == #little
					ifTrue: [LittleEndianBitmap]
					ifFalse: [Bitmap]) new: memoryLimit // 4