bytecode generators
genForwardersInlinedIdenticalOrNotIf: orNot
	"Override to count inlined branches if followed by a conditional branch.
	 We borrow the following conditional branch's counter and when about to
	 inline the comparison we decrement the counter (without writing it back)
	 and if it trips simply abort the inlining, falling back to the normal send which
	 will then continue to the conditional branch which will trip and enter the abort."
	| nextPC postBranchPC targetBytecodePC branchDescriptor counterReg fixup jumpEqual jumpNotEqual
	  counterAddress countTripped unforwardArg unforwardRcvr argReg rcvrReg regMask |
	<var: #fixup type: #'BytecodeFixup *'>
	<var: #countTripped type: #'AbstractInstruction *'>
	<var: #label type: #'AbstractInstruction *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	<var: #jumpEqual type: #'AbstractInstruction *'>
	<var: #jumpNotEqual type: #'AbstractInstruction *'>

	((coInterpreter isOptimizedMethod: methodObj) or: [needsFrame not]) ifTrue:
		[^super genForwardersInlinedIdenticalOrNotIf: orNot].

	regMask := 0.
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	unforwardRcvr := (objectRepresentation isUnannotatableConstant: (self ssValue: 1)) not.
	unforwardArg := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	
	"If an operand is an annotable constant, it may be forwarded, so we need to store it into a 
	register so the forwarder check can jump back to the comparison after unforwarding the constant.
	However, if one of the operand is an unnanotable constant, does not allocate a register for it 
	(machine code will use operations on constants)."
	rcvrReg:= argReg := NoReg.
	self 
		allocateEqualsEqualsRegistersArgNeedsReg: unforwardArg 
		rcvrNeedsReg: unforwardRcvr 
		into: [ :rcvr :arg | rcvrReg:= rcvr. argReg := arg ].
		
	argReg ~= NoReg ifTrue: [ regMask := self registerMaskFor: argReg ].
	rcvrReg ~= NoReg ifTrue: [ regMask := regMask bitOr: (self registerMaskFor: rcvrReg) ].
	
	"Only interested in inlining if followed by a conditional branch."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[^ self 
			genIdenticalNoBranchArgIsConstant: unforwardArg not
			rcvrIsConstant: unforwardRcvr not
			argReg: argReg 
			rcvrReg: rcvrReg 
			orNotIf: orNot].
	
	"If branching the stack must be flushed for the merge"
	self ssFlushTo: simStackPtr - 2.
	
	unforwardArg ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg ].
	unforwardRcvr ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg ].
	
	counterReg := self allocateRegNotConflictingWith: regMask.
	self 
		genExecutionCountLogicInto: [ :cAddress :countTripBranch | 
			counterAddress := cAddress. 
			countTripped := countTripBranch ] 
		counterReg: counterReg.
	
	self assert: (unforwardArg or: [ unforwardRcvr ]).
	self genCmpArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.
	
	orNot == branchDescriptor isBranchTrue "orNot is true for ~~"
		ifFalse:
			[ fixup := (self ensureNonMergeFixupAt: postBranchPC) asUnsignedInteger.
			self JumpZero:  (self ensureNonMergeFixupAt: targetBytecodePC) asUnsignedInteger ]
		ifTrue:
			[ fixup := (self ensureNonMergeFixupAt: targetBytecodePC) asUnsignedInteger.
			self JumpZero: (self ensureNonMergeFixupAt: postBranchPC) asUnsignedInteger ].
	
	self genFallsThroughCountLogicCounterReg: counterReg counterAddress: counterAddress.
	self Jump: fixup.
	
	countTripped jmpTarget: self Label.
	
	"inlined version of #== ignoring the branchDescriptor if the counter trips to have normal state for the optimizer"
	self ssPop: -2. 
	self genCmpArgIsConstant: unforwardArg not rcvrIsConstant: unforwardRcvr not argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2. 
	
	"This code necessarily directly falls through the jumpIf: code which pops the top of the stack into TempReg. 
	We therefore directly assign the result to TempReg to save one move instruction"
	jumpEqual := orNot ifFalse: [self JumpZero: 0] ifTrue: [self JumpNonZero: 0].
	self genMoveFalseR: TempReg.
	jumpNotEqual := self Jump: 0.
	jumpEqual jmpTarget: (self genMoveTrueR: TempReg).
	jumpNotEqual jmpTarget: self Label.
	self ssPushRegister: TempReg.
	
	(self fixupAt: nextPC) notAFixup ifTrue: [ branchReachedOnlyForCounterTrip := true ].
	
	^ 0