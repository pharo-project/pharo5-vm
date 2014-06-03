primitive generators
genInnerPrimitiveNewWithArg: retNoffset
	"Implement primitiveNewWithArg for convenient cases:
	- the receiver has a hash
	- the receiver is variable and not compiled method
	- single word header/num slots < numSlotsMask
	- the result fits in eden

	Here are some dynamic frequencies of class formats in the interpreter doing startUp
	and recompiling ArrayedCollection in a Squeak4.1 image:
		{3251->#arrayFormat.		(Array)
		 1685->#firstByteFormat.	(ByteString, LargePositiveInteger, very few ByteArray)
		 1533->#firstLongFormat.	(Bitmaps, Floats, MatrixTransform2x3, WordArray)
		 110->#weakArrayFormat.	(WeakArray, WeakMessageSend)
		 35->#indexablePointersFormat.	(MethodContext)
		 5->#nonIndexablePointerFormat	(DirectoryEntry)}"

	self subclassResponsibility