compile abstract instructions
mapDeadDescriptorIfNeeded: descriptor 
	"insert nops for dead code that is mapped so that bc 
	 to mc mapping is not many to one"
	<var: #descriptor type: #'BytecodeDescriptor *'>
	self flag: #annotateInstruction .
	(descriptor isMapped
		or: [inBlock > 0 and: [descriptor isMappedInBlock]]) 
		ifTrue: [self annotateBytecode: self Nop].
	^ 0