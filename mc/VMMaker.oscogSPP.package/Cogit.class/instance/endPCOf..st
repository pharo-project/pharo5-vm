compiled methods
endPCOf: aMethod
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| pc end latestContinuation descriptor prim distance targetPC byte bsOffset nExts |
	pc := latestContinuation := coInterpreter startPCOfMethod: aMethod.
	(prim := coInterpreter primitiveIndexOf: aMethod) > 0 ifTrue:
		[(coInterpreter isQuickPrimitiveIndex: prim) ifTrue:
			[^pc - 1]].
	bsOffset := self bytecodeSetOffsetFor: aMethod.
	nExts := 0.
	end := objectMemory numBytesOf: aMethod.
	[pc <= end] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethod.
		descriptor := self generatorAt: byte + bsOffset.
		(descriptor isReturn
		 and: [pc >= latestContinuation]) ifTrue:
			[end := pc].
		(descriptor isBranch or: [descriptor isBlockCreation]) ifTrue:
			[distance := self spanFor: descriptor at: pc exts: nExts in: aMethod.
			 targetPC := pc + descriptor numBytes + distance.
			 latestContinuation := latestContinuation max: targetPC.
			 descriptor isBlockCreation ifTrue:
				[pc := pc + distance]].
		nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0].
		pc := pc + descriptor numBytes].
	^end