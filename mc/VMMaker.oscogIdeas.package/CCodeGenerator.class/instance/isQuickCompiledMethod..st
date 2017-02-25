inlining
isQuickCompiledMethod: aCompiledMethod
	^aCompiledMethod isQuick
	 or: [(#(pushConstant: pushLiteralVariable:) includes: (aCompiledMethod abstractBytecodeMessageAt: aCompiledMethod initialPC) selector)
		and: [(aCompiledMethod abstractBytecodeMessageAt: (InstructionStream on: aCompiledMethod) followingPc) selector == #methodReturnTop]]