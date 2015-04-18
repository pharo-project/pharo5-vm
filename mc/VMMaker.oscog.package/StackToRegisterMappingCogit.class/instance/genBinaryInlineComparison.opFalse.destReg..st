inline primitive generators
genBinaryInlineComparison: opTrue opFalse: opFalse destReg: destReg
	"Inlined comparison. opTrue = jump for true and opFalse = jump for false"
	| nextPC branchDescriptor nExts |	
	nextPC := bytecodePC + 3.
	nExts := 0.	
	[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + (byte0 bitAnd: 256).
	 branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
	 	 nextPC := nextPC + branchDescriptor numBytes].
	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse])
		ifTrue: "This is the path where the inlined comparison is followed immediately by a branch"
			[| targetBytecodePC postBranchPC |
			targetBytecodePC := nextPC
					+ branchDescriptor numBytes
					+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
			postBranchPC := nextPC + branchDescriptor numBytes.
			(self fixupAt: nextPC - initialPC) targetInstruction = 0
				ifTrue: "The next instruction is dead.  we can skip it."
					[deadCode := true.
				 	 self ensureFixupAt: targetBytecodePC - initialPC.
					 self ensureFixupAt: postBranchPC - initialPC ]
				ifFalse:
					[self ssPushConstant: objectMemory trueObject]. "dummy value"
			self gen: (branchDescriptor isBranchTrue ifTrue: [opTrue] ifFalse: [opFalse])
				operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger. 
			deadCode ifFalse: [ self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC) ] ]
		ifFalse: "This is the path where the inlined comparison is *not* followed immediately by a branch"
			[| condJump jump |
			condJump := self gen: opTrue operand: 0.
			self genMoveFalseR: destReg.
	 		jump := self Jump: 0.
			condJump jmpTarget: (self genMoveTrueR: destReg).
			jump jmpTarget: self Label].
	^ 0