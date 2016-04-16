bytecode generators
genVanillaSpecialSelectorEqualsEquals
	| nextPC postBranchPC targetBytecodePC branchDescriptor
	  rcvrReg argReg argIsConstant rcvrIsConstant  |
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	argIsConstant := self ssTop type = SSConstant.
	"they can't be both constants because we do not have instructions manipulating two constants, 
	if this is the case, which can happen due to annotable constants that can be moved in memory 
	with become and therefore can't resolve #== at compilation time, still write the rcvr into a 
	register as if it was not a constant. It's uncommon anyway."
	rcvrIsConstant := argIsConstant not and: [(self ssValue: 1) type = SSConstant]. 
	
	self 
		allocateEqualsEqualsRegistersArgNeedsReg: argIsConstant not 
		rcvrNeedsReg: rcvrIsConstant not 
		into: [ :rcvr :arg | rcvrReg:= rcvr. argReg := arg ].
	
	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[ ^ self genEqualsEqualsNoBranchArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg].
	
	"If branching the stack must be flushed for the merge"
	self ssFlushTo: simStackPtr - 2.
	
	self genEqualsEqualsComparisonArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg.
	self ssPop: 2.

	"Further since there is a following conditional jump bytecode, define
	 non-merge fixups and leave the cond bytecode to set the mergeness."
	(self fixupAt: nextPC - initialPC) notAFixup
		ifTrue: "The next instruction is dead.  we can skip it."
			[deadCode := true.
		 	 self ensureFixupAt: targetBytecodePC - initialPC.
			 self ensureFixupAt: postBranchPC - initialPC]
		ifFalse:
			[self ssPushConstant: objectMemory trueObject]. "dummy value"
		
	self genConditionalBranch: (branchDescriptor isBranchTrue ifTrue: [JumpZero] ifFalse: [JumpNonZero])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.

	"If the branch is dead, then we can just fall through postBranchPC (only a nop in-between), else 
	we need to jump over the code of the branch"
	deadCode ifFalse: [self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC)].
	^0