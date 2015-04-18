bytecode generators
genSpecialSelectorEqualsEqualsWithForwarders
	| primDescriptor nextPC nExts branchDescriptor unforwardRcvr argReg targetBytecodePC
	unforwardArg  rcvrReg jumpNotEqual jumpEqual postBranchPC label fixup |
	<var: #fixup type: #'BytecodeFixup *'>
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

	unforwardRcvr := (objectRepresentation isUnannotatableConstant: (self ssValue: 1)) not.
	unforwardArg := (objectRepresentation isUnannotatableConstant: self ssTop) not.

	"if the rcvr or the arg is an annotable constant, we need to push it to a register 
	else the forwarder check can't jump back to the comparison after unforwarding the constant"
	unforwardArg
		ifTrue: 
			[unforwardRcvr
				ifTrue:
					[self allocateTwoRegistersInto: [:rTop :rNext| argReg := rTop. rcvrReg := rNext].
					 self ssTop popToReg: argReg.
					 (self ssValue:1) popToReg: rcvrReg]
				ifFalse:
					[argReg := self allocateOneRegister.
					 self ssTop popToReg: argReg]]
		ifFalse:
			[self assert: unforwardRcvr.
			 rcvrReg := self allocateOneRegister.
			 (self ssValue:1) popToReg: rcvrReg].

	label := self Label.
	
	"Here we can use Cq because the constant does not need to be annotated"
	self assert: (unforwardArg not or: [argReg notNil]).
	self assert: (unforwardRcvr not or: [rcvrReg notNil]).
	unforwardArg 
		ifFalse: [ self CmpCq: self ssTop constant R: rcvrReg ]
		ifTrue: [ unforwardRcvr
			ifFalse: [ self CmpCq: (self ssValue: 1) constant R: argReg ]
			ifTrue: [ self CmpR: argReg R: rcvrReg ] ].
			 
	self ssPop: 2.

	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[jumpEqual := self JumpZero: 0.
		 unforwardArg ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ].
		 unforwardRcvr ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ].
		 self genMoveFalseR: rcvrReg.
		 jumpNotEqual := self Jump: 0.
		 jumpEqual jmpTarget: (self genMoveTrueR: rcvrReg).
		 jumpNotEqual jmpTarget: self Label.
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

	self assert: (unforwardArg or: [ unforwardRcvr ]).
	branchDescriptor isBranchTrue ifTrue: 
		[ deadCode ifFalse: [ fixup := self ensureNonMergeFixupAt: postBranchPC - initialPC ].
		self JumpZero:  (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
		unforwardArg ifTrue: [ (deadCode or: [ unforwardRcvr ]) 
			ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ]
			ifFalse: [ objectRepresentation 
				genEnsureOopInRegNotForwarded: argReg 
				scratchReg: TempReg 
				ifForwarder: label
				ifNotForwarder: fixup ] ].
		unforwardRcvr ifTrue: [ deadCode 
			ifTrue: [objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ]
			ifFalse: [objectRepresentation 
				genEnsureOopInRegNotForwarded: rcvrReg 
				scratchReg: TempReg 
				ifForwarder: label
				ifNotForwarder: fixup ] ] ].
	branchDescriptor isBranchFalse ifTrue: 
		[ fixup := self ensureNonMergeFixupAt: targetBytecodePC - initialPC.
		self JumpZero: (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger.
		unforwardArg ifTrue: [ unforwardRcvr 
			ifFalse: [objectRepresentation 
				genEnsureOopInRegNotForwarded: argReg 
				scratchReg: TempReg 
				ifForwarder: label
				ifNotForwarder: fixup ]
			ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ] ].
		unforwardRcvr ifTrue: 
			[ objectRepresentation 
				genEnsureOopInRegNotForwarded: rcvrReg 
				scratchReg: TempReg 
				ifForwarder: label
				ifNotForwarder: fixup ].
		"Not reached"].
	^0