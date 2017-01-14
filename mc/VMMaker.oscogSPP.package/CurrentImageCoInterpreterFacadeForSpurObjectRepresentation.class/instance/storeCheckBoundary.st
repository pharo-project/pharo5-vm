accessing
storeCheckBoundary
	^objectMemory storeCheckBoundary ifNil: [16r12345678]