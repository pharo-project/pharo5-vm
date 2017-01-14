compile abstract instructions
loadSubsequentBytesForDescriptor: descriptor at: pc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	descriptor numBytes > 1 ifTrue:
		[byte1 := objectMemory fetchByte: pc + 1 ofObject: methodObj.
		 descriptor numBytes > 2 ifTrue:
			[byte2 := objectMemory fetchByte: pc + 2 ofObject: methodObj.
			 descriptor numBytes > 3 ifTrue:
				[byte3 := objectMemory fetchByte: pc + 3 ofObject: methodObj.
				 descriptor numBytes > 4 ifTrue:
					[self notYetImplemented]]]]