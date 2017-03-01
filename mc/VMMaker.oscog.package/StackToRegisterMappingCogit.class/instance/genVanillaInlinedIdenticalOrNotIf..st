bytecode generators
genVanillaInlinedIdenticalOrNotIf: orNot
	| nextPC postBranchPC targetPC branchDescriptor
	  rcvrReg argReg argIsConstant rcvrIsConstant  |
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetPC := target ].
	
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
	(self fixupAt: nextPC) notAFixup
		ifTrue: "The next instruction is dead.  we can skip it."
			[deadCode := true.
		 	 self ensureFixupAt: targetPC.
			 self ensureFixupAt: postBranchPC]
		ifFalse:
			[self deny: deadCode]. "push dummy value below"
		

	orNot == branchDescriptor isBranchTrue "orNot is true for ~~"
		ifFalse: "a == b ifTrue: ... or a ~~ b ifFalse: ... jump on equal to target pc"
			[self JumpZero:  (self ensureNonMergeFixupAt: targetPC).
			 self Jump: (self ensureNonMergeFixupAt: postBranchPC)]
		ifTrue: "a == b ifFalse: ... or a ~~ b ifTrue: ... jump on equal to post-branch pc"
			[self ensureNonMergeFixupAt: targetPC.
			 self JumpZero: (self ensureNonMergeFixupAt: postBranchPC).
			 self Jump: (self ensureNonMergeFixupAt: targetPC)].

	"Not reached, execution flow has jumped to fixup"
	deadCode ifFalse:
		[self ssPushConstant: objectMemory trueObject]. "dummy value"
	^0