memory space primitives
primitiveSizeInBytes
	<option: #SpurObjectMemory>
	self pop: argumentCount + 1
		 thenPushInteger: (objectMemory totalByteSizeOf: self stackTop)