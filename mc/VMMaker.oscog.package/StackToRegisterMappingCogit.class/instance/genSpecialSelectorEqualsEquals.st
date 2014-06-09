bytecode generators
genSpecialSelectorEqualsEquals
	| nextPC postBranchPC targetBytecodePC primDescriptor branchDescriptor nExts
	  unforwardArg unforwardRcvr jumpEqual jumpNotEqual rcvrReg argReg result |
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	primDescriptor := self generatorAt: byte0.
	"forwarders have been followed in cog:selector:"
	(self ssTop type = SSConstant
	 and: [(self ssValue: 1) type = SSConstant]) ifTrue:
		[self assert: primDescriptor isMapped not.
		 result := self ssTop constant = (self ssValue: 1) constant
									ifTrue: [objectMemory trueObject]
									ifFalse: [objectMemory falseObject].
		 self ssPop: 2.
		 ^self ssPushConstant: result].

	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + (byte0 bitAnd: 256).
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	"If branching the stack must be flushed for the merge"
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifTrue:
		[self ssFlushTo: simStackPtr - 2].

	unforwardRcvr := (self ssValue: 1) type ~= SSConstant
						or: [objectRepresentation shouldAnnotateObjectReference: (self ssValue: 1) constant].
	unforwardArg := self ssTop type ~= SSConstant
						or: [objectRepresentation shouldAnnotateObjectReference: self ssTop constant].

	"Don't use ReceiverResultReg for receiver to keep ReceiverResultReg live.
	 Optimize e.g. rcvr == nil, the common case for ifNil: et al."
	needsFrame
		ifTrue: 
			[unforwardArg ifTrue:
				[self ssAllocateRequiredReg: (argReg := Arg0Reg) upThrough: simStackPtr - 1].
			 self ssAllocateRequiredReg: (rcvrReg := Arg1Reg) upThrough: simStackPtr - 2]
		ifFalse:
			[unforwardArg ifTrue:
				[argReg := self ssAllocatePreferredReg: ClassReg].
			 rcvrReg := self ssAllocatePreferredReg: SendNumArgsReg].
	unforwardArg
		ifTrue:
			[self ssTop popToReg: argReg.
			 objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg.
			 (self ssValue: 1) popToReg: rcvrReg.
			 unforwardRcvr ifTrue:
				[objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg].
			 self CmpR: argReg R: rcvrReg]
		ifFalse:
			[(self ssValue: 1) popToReg: rcvrReg.
			 unforwardRcvr ifTrue:
				[objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg].
			 self CmpCq: self ssTop constant R: rcvrReg].
	self ssPop: 2.

	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[jumpNotEqual := self JumpNonZero: 0.
		 self annotate: (self MoveCw: objectMemory trueObject R: rcvrReg)
			objRef: objectMemory trueObject.
		 jumpEqual := self Jump: 0.
		 jumpNotEqual jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: rcvrReg)
										objRef: objectMemory falseObject).
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
	self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC).
	^0