debug support
validInstructionPointer: theInstrPointer inMethod: aMethod framePointer: fp
	<var: #theInstrPointer type: #usqInt>
	<var: #aMethod type: #usqInt>
	<var: #fp type: #'char *'>
	"Note that we accept anInstrPointer pointing to a callPrimitiveBytecode
	 at the start of a method that contains a primitive.  This because methods like
	 Context(Part)>>reset have to be updated to skip the callPrimtiive bytecode otherwise."
	"-1 for pre-increment in fetchNextBytecode"
	^theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + objectMemory bytesPerOop - 1)
	  and: [theInstrPointer < (aMethod + (objectMemory numBytesOfBytes: aMethod) + objectMemory baseHeaderSize - 1)]