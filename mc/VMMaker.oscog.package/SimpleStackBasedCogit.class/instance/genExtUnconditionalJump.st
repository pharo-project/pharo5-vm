bytecode generators
genExtUnconditionalJump
	"242		11110010	i i i i i i i i	Jump i i i i i i i i (+ Extend B * 256, where bbbbbbbb = sddddddd, e.g. -32768 = i=0, a=0, s=1)"
	| distance target |
	distance := byte1 + (extB << 8).
	self assert: distance = (self v4: (self generatorAt: byte0)
								Long: bytecodePC
								Branch: (extA ~= 0 ifTrue: [1] ifFalse: [0]) + (extB ~= 0 ifTrue: [1] ifFalse: [0])
								Distance: methodObj).
	extB := 0.
	numExtB := 0.
	target := distance + 2 + bytecodePC.
	distance < 0 ifTrue:
		[^self genJumpBackTo: target].
	self genJumpTo: target.
	"The bytecode must be mapped since it can be either forward or backward, and
	  backwards branches must be mapped. So if forward, we need to map."
	self annotateBytecode: self lastOpcode.
	^0