tests-method map
bcpcsAndDescriptorsFor: aMethod bsOffset: bsOffset do: quaternaryBlock
	"Evaluate quaternaryBlock with the pc, byte, descriptor and numExtensions for
	 all the bytecodes in aMethod.  Evaluate with byte, descriptor and numExtensions
	 nil for the initialPC of the mehtod and any blocks within it."
	<doNotGenerate>
	| nExts byte descriptor endpc latestContinuation pc primIdx |
	((primIdx := coInterpreter primitiveIndexOf: aMethod) > 0
	and: [coInterpreter isQuickPrimitiveIndex: primIdx]) ifTrue:
		[^self].
	latestContinuation := pc := coInterpreter startPCOfMethod: aMethod.
	quaternaryBlock value: pc value: nil value: nil value: 0. "stackCheck/entry pc"
	primIdx > 0 ifTrue:
		[pc := pc + (self deltaToSkipPrimAndErrorStoreIn: aMethod
							header: (coInterpreter methodHeaderOf: aMethod))].
	nExts := 0.
	endpc := objectMemory numBytesOf: aMethod.
	[pc <= endpc] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethod.
		descriptor := self generatorAt: byte + bsOffset.
		descriptor isExtension ifFalse:
			[quaternaryBlock value: pc value: byte value: descriptor value: nExts].
		(descriptor isReturn
		 and: [pc >= latestContinuation]) ifTrue:
			[endpc := pc].
		(descriptor isBranch
		 or: [descriptor isBlockCreation]) ifTrue:
			[| targetPC |
			 descriptor isBlockCreation ifTrue:
				[quaternaryBlock value: pc + descriptor numBytes value: nil value: nil value: 0]. "stackCheck/entry pc"
			 targetPC := self latestContinuationPCFor: descriptor at: pc exts: nExts in: aMethod.
			 self assert: targetPC < endpc.
			 latestContinuation := latestContinuation max: targetPC].
		pc := pc + descriptor numBytes.
		nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]]