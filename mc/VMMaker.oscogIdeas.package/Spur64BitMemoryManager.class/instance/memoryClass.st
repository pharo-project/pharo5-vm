simulation
memoryClass
	"Answer the class to use for the memory inst var in simulation.
	 Answer nil if a suitable class isn't available.  This version emulates 64-bit access given a 32-bit element array."
	<doNotGenerate>
	^self endianness == #little
		ifTrue: [LittleEndianBitmap]
		ifFalse: [Bitmap]