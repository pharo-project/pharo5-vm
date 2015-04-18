bytecode generators
genVanillaSpecialSelectorEqualsEquals
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor nExts
	  jumpEqual jumpNotEqual rcvrReg argReg argIsConstant rcvrIsConstant  |
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	primDescriptor := self generatorAt: byte0.

	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + bytecodeSetOffset.
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	"If branching the stack must be flushed for the merge"
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifTrue:
		[self ssFlushTo: simStackPtr - 2].

	"Don't use ReceiverResultReg for receiver to keep ReceiverResultReg live.
	 Optimize e.g. rcvr == nil, the common case for ifNil: et al."
	
	argIsConstant := self ssTop type = SSConstant.
	rcvrIsConstant := argIsConstant and: [ (self ssValue:1) type = SSConstant ].
	
	argIsConstant
		ifFalse: 
			[rcvrIsConstant
				ifFalse:
					[self allocateTwoRegistersInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
					 self ssTop popToReg: argReg.
					 (self ssValue:1) popToReg: rcvrReg]
				ifTrue:
					[argReg := self allocateOneRegister.
					 self ssTop popToReg: argReg]]
		ifTrue:
			[self assert: rcvrIsConstant not.
			 rcvrReg := self allocateOneRegister.
			 (self ssValue:1) popToReg: rcvrReg].
	
	argIsConstant 
		ifTrue: [ self genCompConstant: self ssTop constant R: rcvrReg ]
		ifFalse: [ rcvrIsConstant
			ifTrue: [ self genCompConstant: (self ssValue: 1) constant R: argReg ]
			ifFalse: [ self CmpR: argReg R: rcvrReg ] ].
		
	self ssPop: 2.

	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[jumpNotEqual := self JumpNonZero: 0.
		 self genMoveTrueR: rcvrReg.
		 jumpEqual := self Jump: 0.
		 jumpNotEqual jmpTarget: (self genMoveFalseR: rcvrReg).
		 jumpEqual jmpTarget: self Label.
		 self ssPushRegister: rcvrReg.
		 ^0].

	"Further since there is a following conditional jump bytecode, define
	 non-merge fixups and leave the cond bytecode to set the mergeness."
	targetBytecodePC := nextPC
							+ branchDescriptor numBytes
							+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
	postBranchPC := nextPC + branchDescriptor numBytes.
	(self fixupAt: nextPC - initialPC) targetInstruction = 0
		ifTrue: "The next instruction is dead.  we can skip it."
			[deadCode := true.
		 	 self ensureFixupAt: targetBytecodePC - initialPC.
			 self ensureFixupAt: postBranchPC - initialPC]
		ifFalse:
			[self ssPushConstant: objectMemory trueObject]. "dummy value"
	self gen: (branchDescriptor isBranchTrue ifTrue: [JumpZero] ifFalse: [JumpNonZero])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
		deadCode ifFalse: [self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC)].
	^0