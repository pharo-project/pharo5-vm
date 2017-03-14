tests-method map
bcpcsDescriptorsAndStartpcsFor: aMethod bsOffset: bsOffset do: quinternaryBlock
	"Evaluate quinternaryBlock with the pc, byte, descriptor and numExtensions for
	 all the bytecodes in aMethod.  Evaluate with byte, descriptor and numExtensions
	 nil for the initialPC of the mehtod and any blocks within it."
	<doNotGenerate>
	| nExts byte descriptor endpc latestContinuation pc primIdx blockEndPCs startpcs |
	((primIdx := coInterpreter primitiveIndexOf: aMethod) > 0
	and: [coInterpreter isQuickPrimitiveIndex: primIdx]) ifTrue:
		[^self].
	latestContinuation := pc := coInterpreter startPCOfMethod: aMethod.
	startpcs := OrderedCollection with: pc.
	blockEndPCs := OrderedCollection with: (coInterpreter numBytesOf: aMethod).
	quinternaryBlock value: pc value: nil value: nil value: 0 value: pc. "stackCheck/entry pc"
	primIdx > 0 ifTrue:
		[pc := pc + (self deltaToSkipPrimAndErrorStoreIn: aMethod
							header: (coInterpreter methodHeaderOf: aMethod))].
	nExts := 0.
	endpc := objectMemory numBytesOf: aMethod.
	[pc <= endpc] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethod.
		descriptor := self generatorAt: byte + bsOffset.
		descriptor isExtension ifFalse:
			[quinternaryBlock value: pc value: byte value: descriptor value: nExts value: startpcs last].
		descriptor isReturn ifTrue:
			[pc >= latestContinuation ifTrue:
				[endpc := pc]].
		(descriptor isBranch
		 or: [descriptor isBlockCreation]) ifTrue:
			[| targetPC |
			 targetPC := self latestContinuationPCFor: descriptor at: pc exts: nExts in: aMethod.
			 descriptor isBlockCreation ifTrue:
				[quinternaryBlock value: (startpcs addLast: pc + descriptor numBytes) value: nil value: nil value: 0 value: startpcs last.
				 blockEndPCs addLast: targetPC]. "stackCheck/entry pc"
			 self assert: targetPC < endpc.
			 latestContinuation := latestContinuation max: targetPC].
		descriptor isReturn ifTrue:
			[pc + descriptor numBytes >= blockEndPCs last ifTrue:
				[blockEndPCs removeLast.
				 startpcs removeLast]].
		pc := pc + descriptor numBytes.
		nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]]