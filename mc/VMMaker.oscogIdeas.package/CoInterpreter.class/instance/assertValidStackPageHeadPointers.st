debug support
assertValidStackPageHeadPointers
	self assert: stackPage headFP < stackPage baseAddress.
	self assert: stackPage headSP < stackPage headFP.
	self assert: stackPage headFP > stackPage headSP.
	self assert: stackPage headSP >= (stackPage realStackLimit - self stackLimitOffset)