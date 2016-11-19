simulation
memoryClass
	<doNotGenerate>
	^self endianness == #little
		ifTrue: [LittleEndianBitmap]
		ifFalse: [Bitmap]