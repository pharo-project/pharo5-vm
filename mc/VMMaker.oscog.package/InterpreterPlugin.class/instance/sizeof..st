simulation support
sizeof: objectSymbolOrClass
	<doNotGenerate>
	"In the simulator file handles are just integer indices into openFiles and so need only be BytesPerWord big.
	 But in the actual VM they are 5 words long.  We assume the file offset type is always 64-bit"
	objectSymbolOrClass == #SQFile ifTrue:
		[^interpreterProxy wordSize * 5].
	objectSymbolOrClass == #squeakFileOffsetType ifTrue:
		[^8].
	^super sizeof: objectSymbolOrClass