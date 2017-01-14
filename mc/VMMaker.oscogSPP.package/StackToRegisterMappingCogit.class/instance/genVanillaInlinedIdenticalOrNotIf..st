bytecode generators
genVanillaInlinedIdenticalOrNotIf: orNot
	| nextPC postBranchPC targetBytecodePC branchDescriptor
	  rcvrReg argReg argIsConstant rcvrIsConstant  |
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	argIsConstant := self ssTop type = SSConstant.
	"They can't be both constants to use correct machine opcodes.
	 However annotable constants can't be resolved statically, hence we need to careful."
	rcvrIsConstant := argIsConstant not and: [(self ssValue: 1) type = SSConstant].
	
	self 
		allocateEqualsEqualsRegistersArgNeedsReg: argIsConstant not 
		rcvrNeedsReg: rcvrIsConstant not 
		into: [ :rcvr :arg | rcvrReg:= rcvr. argReg := arg ].
	
	"If not followed by a branch, resolve to true or false."
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse]) ifFalse:
		[^ self 
			genIdenticalNoBranchArgIsConstant: argIsConstant 
			rcvrIsConstant: rcvrIsConstant 
			argReg: argReg 
			rcvrReg: rcvrReg 
			orNotIf: orNot].
	
	"If branching the stack must be flushed for the merge"
	self ssFlushTo: simStackPtr - 2.
	
	self genCmpArgIsConstant: argIsConstant rcvrIsConstant: rcvrIsConstant argReg: argReg rcvrReg: rcvrReg.
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
		
	"We could simplify this with a xor:"
	self genConditionalBranch: (orNot 
						ifFalse: [branchDescriptor isBranchTrue ifTrue: [JumpZero] ifFalse: [JumpNonZero]]
						ifTrue: [branchDescriptor isBranchTrue ifTrue: [JumpNonZero] ifFalse: [JumpZero]])
		operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.

	"If the branch is dead, then we can just fall through postBranchPC (only a nop in-between), else 
	we need to jump over the code of the branch"
	deadCode ifFalse:
		[self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC).
		 self ssPushConstant: objectMemory trueObject]. "dummy value"
	^0