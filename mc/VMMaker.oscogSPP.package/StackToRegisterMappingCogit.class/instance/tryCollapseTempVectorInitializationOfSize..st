peephole optimizations
tryCollapseTempVectorInitializationOfSize: slots
	"If the sequence of bytecodes is
		push: (Array new: 1)
		popIntoTemp: tempIndex
		pushConstant: const or pushTemp: n
		popIntoTemp: 0 inVectorAt: tempIndex
	 collapse this into
		tempAt: tempIndex put: {const or temp}
	 and answer true, otherwise answer false.
	 One might think that we should look for a sequence of more than
	 one pushes and pops but this is extremely rare.
	 Exclude pushRcvr: n to avoid potential complications with context inst vars."
	| pushArrayDesc storeArrayDesc pushValueDesc storeValueDesc tempIndex remoteTempIndex reg |
	<var: #pushArrayDesc type: #'BytecodeDescriptor *'>
	<var: #pushValueDesc type: #'BytecodeDescriptor *'>
	<var: #storeArrayDesc type: #'BytecodeDescriptor *'>
	<var: #storeValueDesc type: #'BytecodeDescriptor *'>
	slots ~= 1 ifTrue:
		[^false].
	pushArrayDesc := self generatorAt: bytecodeSetOffset
										+ (objectMemory
												fetchByte: bytecodePC
												ofObject: methodObj).
	self assert: pushArrayDesc generator == #genPushNewArrayBytecode.
	storeArrayDesc := self generatorAt: bytecodeSetOffset
										+ (objectMemory
												fetchByte: bytecodePC
														+ pushArrayDesc numBytes
												ofObject: methodObj).
	storeArrayDesc generator == #genStoreAndPopTemporaryVariableBytecode
		ifTrue:
			[tempIndex := (objectMemory
								fetchByte: bytecodePC + pushArrayDesc numBytes
								ofObject: methodObj) bitAnd: 16r7]
		ifFalse:
			[storeArrayDesc generator == #genLongStoreAndPopTemporaryVariableBytecode ifFalse:
				[^false].
			 tempIndex := objectMemory
								fetchByte: bytecodePC + pushArrayDesc numBytes + 1
								ofObject: methodObj].
	pushValueDesc := self generatorAt: bytecodeSetOffset
										+ (objectMemory
												fetchByte: bytecodePC
														+ pushArrayDesc numBytes
														+ storeArrayDesc numBytes
												ofObject: methodObj).
	(pushValueDesc generator == #genPushLiteralConstantBytecode
	 or: [pushValueDesc generator == #genPushQuickIntegerConstantBytecode
	 or: [pushValueDesc generator == #genPushTemporaryVariableBytecode]]) ifFalse:
		[^false].
	storeValueDesc := self generatorAt: bytecodeSetOffset
										+ (objectMemory
												fetchByte: bytecodePC
														+ pushArrayDesc numBytes
														+ storeArrayDesc numBytes
														+ pushValueDesc numBytes
												ofObject: methodObj).
	remoteTempIndex := objectMemory
												fetchByte: bytecodePC
														+ pushArrayDesc numBytes
														+ storeArrayDesc numBytes
														+ pushValueDesc numBytes
														+ 2
												ofObject: methodObj.
	(storeValueDesc generator == #genStoreAndPopRemoteTempLongBytecode
	 and: [tempIndex = remoteTempIndex]) ifFalse:
		[^false].

	objectRepresentation genNewArrayOfSize: 1 initialized: false.
	self evaluate: pushValueDesc at: bytecodePC + pushArrayDesc numBytes + storeArrayDesc numBytes.
	reg := self ssStorePop: true toPreferredReg: TempReg.
	objectRepresentation
		genStoreSourceReg: reg
		slotIndex: 0
		intoNewObjectInDestReg: ReceiverResultReg.
	self ssPushRegister: ReceiverResultReg.
	self evaluate: storeArrayDesc at: bytecodePC + pushArrayDesc numBytes.
	bytecodePC := bytecodePC
					"+ pushArrayDesc numBytes this gets added by nextBytecodePCFor:at:exts:in:"
					+ storeArrayDesc numBytes
					+ pushValueDesc numBytes
					+ storeValueDesc numBytes.
	^true