bytecode generators
genForwardersInlinedIdenticalOrNotIf: orNot
	| nextPC branchDescriptor unforwardRcvr argReg targetPC
	  unforwardArg  rcvrReg postBranchPC retry fixup
	  comparison
	  needMergeToTarget needMergeToContinue |
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #toContinueLabel type: #'AbstractInstruction *'>
	<var: #toTargetLabel type: #'AbstractInstruction *'>
	<var: #comparison type: #'AbstractInstruction *'>
	<var: #retry type: #'AbstractInstruction *'>
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetPC := target ].

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
		[^self 
			genIdenticalNoBranchArgIsConstant: unforwardArg not
			rcvrIsConstant: unforwardRcvr not
			argReg: argReg 
			rcvrReg: rcvrReg 
			orNotIf: orNot].
	
	self assert: (unforwardArg or: [unforwardRcvr]).

	retry := self Label.
	self genCmpArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.

	(self fixupAt: nextPC) notAFixup "The next instruction is dead.  we can skip it."
		ifTrue:  [deadCode := true]
		ifFalse: [self deny: deadCode]. "push dummy value below"

	"self printSimStack; printSimStack: (self fixupAt: postBranchPC) mergeSimStack"
	"If there are merges to be performed on the forward branches we have to execute
	 the merge code only along the path requiring that merge, and exactly once."
	needMergeToTarget := self mergeRequiredForJumpTo: targetPC.
	needMergeToContinue := self mergeRequiredForJumpTo: postBranchPC.
	orNot == branchDescriptor isBranchTrue
		ifFalse: "a == b ifTrue: ... or a ~~ b ifFalse: ... jump on equal to target pc"
			[fixup := needMergeToContinue
						ifTrue: [0] "jumps will fall-through to to-continue merge code"
						ifFalse: [self ensureFixupAt: postBranchPC].
			 comparison := self JumpZero: (needMergeToTarget
												ifTrue: [0] "comparison will be fixed up to to-target merge code"
												ifFalse: [self ensureFixupAt: targetPC])]
		ifTrue: "a == b ifFalse: ... or a ~~ b ifTrue: ... jump on equal to post-branch pc"
			[fixup := needMergeToTarget
						ifTrue: [0] "jumps will fall-through to to-target merge code"
						ifFalse: [self ensureFixupAt: targetPC].
			 comparison := self JumpZero: (needMergeToContinue
												ifTrue: [0] "comparison will be fixed up to to-continue merge code"
												ifFalse: [self ensureFixupAt: postBranchPC])].

	"The forwarders check(s) need(s) to jump back to the comparison (retry) if a forwarder is found,
	 else jump forward either to the next forwarder check or to the postBranch or branch target (fixup).
	 But if there is merge code along a path, the jump must be to the merge code."
	(unforwardArg and: [unforwardRcvr]) ifTrue:
		[objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: retry].
	objectRepresentation 
		genEnsureOopInRegNotForwarded: (unforwardRcvr ifTrue: [rcvrReg] ifFalse: [argReg]) 
		scratchReg: TempReg 
		ifForwarder: retry
		ifNotForwarder: fixup.
	"If fixup is zero then the ifNotForwarder path falls through to a Label which is interpreted
	 as either to-continue or to-target, depending on orNot == branchDescriptor isBranchTrue."
	orNot == branchDescriptor isBranchTrue
		ifFalse: "a == b ifTrue: ... or a ~~ b ifFalse: ... jump on equal to target pc"
			[needMergeToContinue ifTrue: "fall-through to to-continue merge code"
				[self Jump: (self ensureFixupAt: postBranchPC)].
			 needMergeToTarget ifTrue: "fixup comparison to to-target merge code"
				[comparison jmpTarget: self Label.
				 self Jump: (self ensureFixupAt: targetPC)]]
		ifTrue: "a == b ifFalse: ... or a ~~ b ifTrue: ... jump on equal to post-branch pc"
			[needMergeToTarget ifTrue: "fall-through to to-target merge code"
				[self Jump: (self ensureFixupAt: targetPC)].
			 needMergeToContinue ifTrue: "fixup comparison to to-continue merge code"
				[comparison jmpTarget: self Label.
				 self Jump: (self ensureFixupAt: postBranchPC)]].

	deadCode ifFalse: "duplicate the merge fixup's top of stack so as to avoid a false confict."
		[self ssPushDesc: ((self fixupAt: nextPC) mergeSimStack at: simStackPtr + 1)].
	^0