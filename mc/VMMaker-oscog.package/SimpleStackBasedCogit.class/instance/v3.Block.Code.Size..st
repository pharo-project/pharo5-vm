span functions
v3: descriptor Block: pc Code: nExts Size: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	self assert: nExts <= 0.
	^((objectMemory fetchByte: pc + 2 ofObject: aMethodObj) << 8)
	+ (objectMemory fetchByte: pc + 3 ofObject: aMethodObj)