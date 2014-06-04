span functions
v3: descriptor ShortForward: pc Branch: nExts Distance: aMethodObj
	"N.B.  This serves for both BlueBook/V3 and V4 short jumps."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	self assert: nExts = 0.
	^((objectMemory fetchByte: pc ofObject: aMethodObj) bitAnd: 7) + 1