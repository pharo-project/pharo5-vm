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
			self ssPushConstant: objectMemory trueObject. "dummy object"
			self gen: (branchDescriptor isBranchTrue ifTrue: [opTrue] ifFalse: [opFalse])
				operand: (self ensureNonMergeFixupAt: targetBytecodePC - initialPC) asUnsignedInteger.
			self Jump: (self ensureNonMergeFixupAt: postBranchPC - initialPC)]
		ifFalse: "This is the path where the inlined comparison is *not* followed immediately by a branch"
			[| condJump jump |
			condJump := self gen: opTrue operand: 0.
	 		self 
				annotate: (self MoveCw: objectMemory falseObject R: destReg) 
				objRef: objectMemory falseObject.
	 		jump := self Jump: 0.
			condJump jmpTarget: (self 
				annotate: (self MoveCw: objectMemory trueObject R: destReg) 
				objRef: objectMemory trueObject).
			jump jmpTarget: self Label].
	^ 0