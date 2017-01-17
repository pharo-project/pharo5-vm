simulation stack
ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr
	self ssAllocateRequiredRegMask: requiredRegsMask upThrough: stackPtr upThroughNative: simNativeStackPtr.
