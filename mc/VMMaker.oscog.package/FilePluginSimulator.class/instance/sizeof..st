simulation
sizeof: objectSymbolOrClass
	"In the simulator file handles are just integer indices into openFiles and so need only be BytesPerWord big.  We assume the file offset type is always 64-bit"
	| index |
	index := #(	#SQFile #squeakFileOffsetType)
						indexOf: objectSymbolOrClass
						ifAbsent: [^super sizeof: objectSymbolOrClass].
	^{interpreterProxy wordSize.
	    8 } at: index