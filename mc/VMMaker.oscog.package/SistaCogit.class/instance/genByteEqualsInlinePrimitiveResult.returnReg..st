inline primitive generators
genByteEqualsInlinePrimitiveResult: jmp returnReg: reg
	"Byte equal is falling through if the result is true, or jumping using jmp if the result is false.
	 The method is required to set the jump target of jmp.
	 We look ahead for a branch and pipeline the jumps if possible..
	 ReturnReg is used only if not followed immediately by a branch."
	| branchDescriptor nextPC postBranchPC targetBytecodePC localJump canElide |
	<var: #localJump type: #'AbstractInstruction *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	"Case 1 - not followed by a branch"
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse])
		ifFalse: 
			[self genMoveTrueR: reg.
			 localJump := self Jump: 0.
			 jmp jmpTarget: (self genMoveFalseR: reg).
			 localJump jmpTarget: self Label.
			 self ssPushRegister: reg.
			^ 0].

	"Case 2 - followed by a branch"
	(self fixupAt: nextPC) notAFixup
		ifTrue: "The next instruction is dead.  we can skip it."
			[deadCode := true.
		 	 self ensureFixupAt: targetBytecodePC.
			 self ensureFixupAt: postBranchPC ]
		ifFalse:
			[self ssPushConstant: objectMemory trueObject]. "dummy value"
	"We can only elide the jump if the pc after nextPC is the same as postBranchPC.
	 Branch following means it may not be."
	self nextDescriptorExtensionsAndNextPCInto:
		[:iguana1 :iguana2 :iguana3 :followingPC| nextPC := followingPC].
	canElide := deadCode and: [nextPC = postBranchPC].
	 branchDescriptor isBranchTrue
		ifTrue: 
			[ self Jump: (self ensureNonMergeFixupAt: targetBytecodePC).
			  canElide 
					ifFalse: [ jmp jmpTarget: (self ensureNonMergeFixupAt: postBranchPC) ]
					ifTrue: [ jmp jmpTarget: self Label ] ]
		ifFalse: [ canElide ifFalse: [ self Jump: (self ensureNonMergeFixupAt: postBranchPC).
				 jmp jmpTarget: (self ensureNonMergeFixupAt: targetBytecodePC) ] ].
	^0