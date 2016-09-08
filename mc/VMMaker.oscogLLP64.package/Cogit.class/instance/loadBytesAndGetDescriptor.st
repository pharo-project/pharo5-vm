compile abstract instructions
loadBytesAndGetDescriptor
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| descriptor |
	byte0 := (objectMemory fetchByte: bytecodePC ofObject: methodObj)  + bytecodeSetOffset.
	descriptor := self generatorAt: byte0.
	self loadSubsequentBytesForDescriptor: descriptor at: bytecodePC.
	^ descriptor
	
	