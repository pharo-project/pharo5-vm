bytecode generators
genSpecialSelectorEqualsEqualsWithForwarders
	"Override to count inlined branches if followed by a conditional branch.
	 We borrow the following conditional branch's counter and when about to
	 inline the comparison we decrement the counter (without writing it back)
	 and if it trips simply abort the inlining, falling back to the normal send which
	 will then continue to the conditional branch which will trip and enter the abort."
	| nextPC postBranchPC targetBytecodePC branchDescriptor label counterReg fixup
	  counterAddress countTripped unforwardArg unforwardRcvr argReg rcvrReg regMask |
	<var: #fixup type: #'BytecodeFixup *'>
	<var: #countTripped type: #'AbstractInstruction *'>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>

	((coInterpreter isOptimizedMethod: methodObj) or: [needsFrame not]) ifTrue: [ ^ super genSpecialSelectorEqualsEquals ].

	regMask := 0.
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	unforwardRcvr := (objectRepresentation isUnannotatableConstant: (self ssValue: 1)) not.
	unforwardArg := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	
	"If an operand is an annotable constant, it may be forwarded, so we need to store it into a 
	register so the forwarder check can jump back to the comparison after unforwarding the constant.
	However, if one of the operand is an unnanotable constant, does not allocate a register for it 
	(machine code will use operations on constants)."
	self 
		allocateEqualsEqualsRegistersArgNeedsReg: unforwardArg 
		rcvrNeedsReg: unforwardRcvr 
		into: [ :rcvr :arg | rcvrReg:= rcvr. argReg := arg ].
		
	argReg ifNotNil: [ regMask := self registerMaskFor: argReg ].
	rcvrReg ifNotNil: [ regMask := regMask bitOr: (self registerMaskFor: rcvrReg) ].
	
	"Only interested in inlining if followed by a conditional branch."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[^ self genEqualsEqualsNoBranchArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg].

	counterReg := self allocateRegNotConflictingWith: regMask. "Use this as the count reg, can't conflict with the registers for the arg and the receiver of #==."
	counterAddress := counters + ((self sizeof: #sqInt) * counterIndex).
	self flag: 'will need to use MoveAw32:R: if 64 bits'.
	self assert: objectMemory wordSize = CounterBytes.
	self MoveAw: counterAddress R: counterReg.
	self SubCq: 16r10000 R: counterReg. "Count executed"
	"If counter trips simply abort the inlined comparison and send continuing to the following
	 branch *without* writing back.  A double decrement will not trip the second time."
	countTripped := self JumpCarry: 0.
	self MoveR: counterReg Aw: counterAddress. "write back"
	
	self assert: (unforwardArg or: [ unforwardRcvr ]).
	
	"If branching the stack must be flushed for the merge"
	self ssFlushTo: simStackPtr - 2.
	
	label := self Label.
	
	self genEqualsEqualsComparisonArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	
	self ssPop: 2. "pop by 2 temporarily  for the fixups"
	branchDescriptor isBranchTrue 
		ifTrue: 
			[ fixup := self ensureNonMergeFixupAt: postBranchPC - initialPC.
			self JumpZero: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger. ]
		ifFalse: 
			[ fixup := self ensureNonMergeFixupAt: targetBytecodePC - initialPC.
			self JumpZero: (self ensureNonMergeFixupAt: postBranchPC - initialPC) asUnsignedInteger. ].
	unforwardArg ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label  ].
	unforwardRcvr ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ].
	self ssPop: -2. 
	
	"the jump has not been taken and forwarders have been followed."
	self SubCq: 1 R: counterReg. "Count untaken"
	self MoveR: counterReg Aw: counterAddress. "write back"
	self Jump: fixup.
	
	countTripped jmpTarget: self Label.
	
	"inlined version of #== ignoring the branchDescriptor if the counter trips to have normal state for the optimizer"
	self genEqualsEqualsNoBranchArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	^ 0