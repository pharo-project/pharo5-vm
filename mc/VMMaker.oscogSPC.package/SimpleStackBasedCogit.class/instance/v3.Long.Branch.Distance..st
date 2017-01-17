span functions
v3: descriptor Long: pc Branch: nExts Distance: aMethodObj
	"Answer the distance of a two byte forward long jump."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	self assert: nExts = 0.
	^(((objectMemory fetchByte: pc ofObject: aMethodObj) bitAnd: 7) - 4 << 8)
	 + (objectMemory fetchByte: pc + 1 ofObject: aMethodObj)