bytecode generators
genForwardersInlinedIdenticalOrNotIf: orNot
	| nextPC branchDescriptor unforwardRcvr argReg targetBytecodePC
	unforwardArg  rcvrReg postBranchPC label fixup |
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #label type: #'AbstractInstruction *'>
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].

	"If an operand is an annotable constant, it may be forwarded, so we need to store it into a 
	register so the forwarder check can jump back to the comparison after unforwarding the constant.
	However, if one of the operand is an unnanotable constant, does not allocate a register for it 
	(machine code will use operations on constants) and does not generate forwarder checks."
	unforwardRcvr := (objectRepresentation isUnannotatableConstant: (self ssValue: 1)) not.
	unforwardArg := (objectRepresentation isUnannotatableConstant: self ssTop) not.

	self 
		allocateEqualsEqualsRegistersArgNeedsReg: unforwardArg 
		rcvrNeedsReg: unforwardRcvr 
		into: [ :rcvr :arg | rcvrReg:= rcvr. argReg := arg ].

	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[^ self 
			genIdenticalNoBranchArgIsConstant: unforwardArg not
			rcvrIsConstant: unforwardRcvr not
			argReg: argReg 
			rcvrReg: rcvrReg 
			orNotIf: orNot].
	
	label := self Label.
	self genCmpArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.

	"Further since there is a following conditional jump bytecode, define
	 non-merge fixups and leave the cond bytecode to set the mergeness."
	(self fixupAt: nextPC - initialPC) notAFixup
		ifTrue: "The next instruction is dead.  we can skip it."
			[deadCode := true.
		 	 self ensureFixupAt: targetBytecodePC - initialPC.
			 self ensureFixupAt: postBranchPC - initialPC]
		ifFalse:
			[self deny: deadCode]. "push dummy value below"

	self assert: (unforwardArg or: [unforwardRcvr]).
	"We could use (branchDescriptor isBranchTrue xor: orNot) to simplify this."
	orNot 
		ifFalse: [branchDescriptor isBranchTrue
					ifTrue: 
						[ fixup := (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger.
						self JumpZero:  (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger ]
					ifFalse: "branchDescriptor is branchFalse"
						[ fixup := (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
						self JumpZero: (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger ]]
		ifTrue: [branchDescriptor isBranchTrue
					ifFalse: "branchDescriptor is branchFalse"
						[ fixup := (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger.
						self JumpZero:  (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger ]
					ifTrue:
						[ fixup := (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
						self JumpZero: (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger ]].

	deadCode ifFalse:
		[self ssPushConstant: objectMemory trueObject]. "dummy value"
	"The forwarders checks need to jump back to the comparison (label) if a forwarder is found, else 
	jump forward either to the next forwarder check or to the postBranch or branch target (fixup)."
	unforwardArg ifTrue: 
		[ unforwardRcvr
			ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ]
			ifFalse: [ objectRepresentation 
				genEnsureOopInRegNotForwarded: argReg 
				scratchReg: TempReg 
				ifForwarder: label
				ifNotForwarder: fixup ] ].
	unforwardRcvr ifTrue: 
		[ objectRepresentation 
			genEnsureOopInRegNotForwarded: rcvrReg 
			scratchReg: TempReg 
			ifForwarder: label
			ifNotForwarder: fixup ].
		
	"Not reached, execution flow have jumped to fixup"
	
	^0