bytecode generators
genSpecialSelectorEqualsEquals
	| argReg rcvrReg nextPC postBranchPC targetBytecodePC nExts
	  primDescriptor branchDescriptor jumpEqual jumpNotEqual resultReg |
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	self flag: 'rewrite this crap.'.
	self ssPop: 2.
	resultReg := self availableRegisterOrNil.
	resultReg ifNil:
		[(self numRegArgs > 1 and: [needsFrame not and: [methodOrBlockNumArgs = 2]]) ifTrue:
			[self halt].
		self ssAllocateRequiredReg: (resultReg := Arg1Reg)].
	self ssPush: 2.
	(self ssTop type = SSConstant
	 and: [self ssTop spilled not]) "if spilled we must generate a real pop"
		ifTrue:
			[(self ssValue: 1) type = SSRegister
				ifTrue: [rcvrReg := (self ssValue: 1) register]
				ifFalse:
					[(self ssValue: 1) popToReg: (rcvrReg := resultReg)].
			(objectRepresentation shouldAnnotateObjectReference: self ssTop constant)
				ifTrue: [self annotate: (self CmpCw: self ssTop constant R: rcvrReg)
							objRef: self ssTop constant]
				ifFalse: [self CmpCq: self ssTop constant R: rcvrReg].
			self ssPop: 1]
		ifFalse:
			[argReg := self ssStorePop: true toPreferredReg: TempReg.
			 rcvrReg := argReg = resultReg
							ifTrue: [TempReg]
							ifFalse: [resultReg].
			self ssTop popToReg: rcvrReg.
			self CmpR: argReg R: rcvrReg].
	self ssPop: 1; ssPushRegister: resultReg.
	primDescriptor := self generatorAt: byte0.
	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + (byte0 bitAnd: 256).
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	(branchDescriptor isBranchTrue
	 or: [branchDescriptor isBranchFalse])
		ifTrue:
			[self ssFlushTo: simStackPtr - 1.
			 targetBytecodePC := nextPC
								+ branchDescriptor numBytes
								+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
			 postBranchPC := nextPC + branchDescriptor numBytes.
			 (self fixupAt: nextPC - initialPC) targetInstruction = 0 ifTrue: "The next instruction is dead.  we can skip it."
				[deadCode := true.
				 self ssPop: 1. "the conditional branch bytecodes pop the item tested from the stack."
				 self ensureFixupAt: targetBytecodePC - initialPC.
				 self ensureFixupAt: postBranchPC - initialPC].
			 self gen: (branchDescriptor isBranchTrue
						ifTrue: [JumpZero]
						ifFalse: [JumpNonZero])
				operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
			 self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC)]
		ifFalse:
			[jumpNotEqual := self JumpNonZero: 0.
			 self annotate: (self MoveCw: objectMemory trueObject R: resultReg)
				objRef: objectMemory trueObject.
			 jumpEqual := self Jump: 0.
			 jumpNotEqual jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: resultReg)
											objRef: objectMemory falseObject).
			 jumpEqual jmpTarget: self Label].
	resultReg == ReceiverResultReg ifTrue:
		[optStatus isReceiverResultRegLive: false].
	^0