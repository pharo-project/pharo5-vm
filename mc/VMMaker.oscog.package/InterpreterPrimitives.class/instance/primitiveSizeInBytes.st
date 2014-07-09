memory space primitives
primitiveSizeInBytes
	<option: #SpurObjectMemory>
	| byteSize |
	byteSize := objectMemory totalByteSizeOf: self stackTop.
	self pop: argumentCount + 1
		 thenPush: (self positive64BitIntegerFor: byteSize)