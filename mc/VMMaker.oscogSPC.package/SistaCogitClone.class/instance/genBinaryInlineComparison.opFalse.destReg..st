inline primitive generators
genBinaryInlineComparison: opTrue opFalse: opFalse destReg: destReg
	"Inlined comparison. opTrue = jump for true and opFalse = jump for false"
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	| nextPC branchDescriptor targetBytecodePC postBranchPC |	
		
	self extractMaybeBranchDescriptorInto: [ :descr :next :postBranch :target | 
		branchDescriptor := descr. nextPC := next. postBranchPC := postBranch. targetBytecodePC := target ].
	
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse])
		ifTrue: "This is the path where the inlined comparison is followed immediately by a branch"
			[ (self fixupAt: nextPC - initialPC) notAFixup
				ifTrue: "The next instruction is dead.  we can skip it."
					[deadCode := true.
				 	 self ensureFixupAt: targetBytecodePC - initialPC.
					 self ensureFixupAt: postBranchPC - initialPC ]
				ifFalse:
					[self ssPushConstant: objectMemory trueObject]. "dummy value"
			self genConditionalBranch: (branchDescriptor isBranchTrue ifTrue: [opTrue] ifFalse: [opFalse])
				operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger. 
			deadCode ifFalse: [ self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC) ] ]
		ifFalse: "This is the path where the inlined comparison is *not* followed immediately by a branch"
			[| condJump jump |
			condJump := self genConditionalBranch: opTrue operand: 0.
			self genMoveFalseR: destReg.
	 		jump := self Jump: 0.
			condJump jmpTarget: (self genMoveTrueR: destReg).
			jump jmpTarget: self Label].
	^ 0