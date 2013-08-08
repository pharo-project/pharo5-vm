tests-method map
bcpcsAndDescriptorsFor: aMethod do: trinaryBlock
	<doNotGenerate>
	| bsOffset nExts byte descriptor endpc latestContinuation pc primIdx |
	((primIdx := coInterpreter primitiveIndexOf: aMethod) > 0
	and: [coInterpreter isQuickPrimitiveIndex: primIdx]) ifTrue:
		[^self].
	latestContinuation := pc := coInterpreter startPCOfMethod: aMethod.
	trinaryBlock value: pc value: nil value: nil. "stackCheck/entry pc"
	bsOffset := self bytecodeSetOffsetFor: aMethod.
	nExts := 0.
	endpc := objectMemory byteLengthOf: aMethod.
	[pc <= endpc] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethod.
		descriptor := self generatorAt: byte + bsOffset.
		trinaryBlock value: pc value: byte value: descriptor.
		(descriptor isReturn
		 and: [pc >= latestContinuation]) ifTrue:
			[endpc := pc].
		(descriptor isBranch
		 or: [descriptor isBlockCreation]) ifTrue:
			[| targetPC |
			 descriptor isBlockCreation ifTrue:
				[trinaryBlock value: pc + descriptor numBytes value: nil value: nil]. "stackCheck/entry pc"
			 targetPC := self latestContinuationPCFor: descriptor at: pc exts: nExts in: aMethod.
			 self assert: targetPC < endpc.
			 latestContinuation := latestContinuation max: targetPC].
		pc := pc + descriptor numBytes.
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]]