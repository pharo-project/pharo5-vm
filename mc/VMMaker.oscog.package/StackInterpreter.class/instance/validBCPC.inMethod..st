debug support
validBCPC: thePC inMethod: aMethod
	<var: #aMethod type: #usqInt>
	"Note that we accept anInstrPointer pointing to a callPrimitiveBytecode
	 at the start of a method that contains a primitive.  This because methods like
	 Context(Part)>>reset have to be updated to skip the callPrimtiive bytecode otherwise."
	"-1 for pre-increment in fetchNextBytecode"
	^thePC >= (objectMemory lastPointerOf: aMethod)
	  and: [thePC < (objectMemory numBytesOfBytes: aMethod)]