debug support
assertValidExternalStackPointers
	self assert: framePointer < stackPage baseAddress.
	self assert: stackPointer < framePointer.
	self assert: framePointer > stackPointer.
	self assert: stackPointer >= (stackPage realStackLimit - self stackLimitOffset)