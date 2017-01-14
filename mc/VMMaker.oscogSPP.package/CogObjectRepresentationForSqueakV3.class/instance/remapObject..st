garbage collection
remapObject: objOop
	self assert: (objectMemory addressCouldBeObj: objOop).
	^objectMemory remap: objOop