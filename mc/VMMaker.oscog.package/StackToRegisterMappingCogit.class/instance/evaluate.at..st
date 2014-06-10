peephole optimizations
evaluate: descriptor at: pc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	byte0 := objectMemory fetchByte: pc ofObject: methodObj.
	self assert: descriptor = (self generatorAt: bytecodeSetOffset + byte0).
	self loadSubsequentBytesForDescriptor: descriptor at: pc.
	self perform: descriptor generator