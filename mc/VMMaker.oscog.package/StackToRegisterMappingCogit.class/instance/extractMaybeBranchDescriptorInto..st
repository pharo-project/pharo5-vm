bytecode generator support
extractMaybeBranchDescriptorInto: fourArgBlock
	"Looks one instruction ahead of the current bytecodePC and answers its bytecode descriptor and its pc.
	 If the instruction found is a branch, also answers the pc after the branch and the pc targeted by the branch.
	 For convenience, avoiding duplication in the senders, it follows those two pcs to their eventual targets."
	| primDescriptor nextPC nExts branchDescriptor targetBytecodePC postBranchPC |
	<inline: true>
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	<var: #branchDescriptor type: #'BytecodeDescriptor *'>
	
	primDescriptor := self generatorAt: byte0.

	nextPC := bytecodePC + primDescriptor numBytes.
	nExts := 0.
	[[branchDescriptor := self generatorAt: (objectMemory fetchByte: nextPC ofObject: methodObj) + bytecodeSetOffset.
	  branchDescriptor isExtension] whileTrue:
		[nExts := nExts + 1.
		 nextPC := nextPC + branchDescriptor numBytes].
	 branchDescriptor isUnconditionalBranch]
		whileTrue:
			[nextPC := self eventualTargetOf: nextPC
											+ branchDescriptor numBytes
											+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj)].

	targetBytecodePC := postBranchPC := 0.

	(branchDescriptor isBranchTrue or: [branchDescriptor isBranchFalse])
		ifTrue: 
			[targetBytecodePC := self eventualTargetOf: nextPC
														+ branchDescriptor numBytes
														+ (self spanFor: branchDescriptor at: nextPC exts: nExts in: methodObj).
			 postBranchPC := self eventualTargetOf: nextPC + branchDescriptor numBytes]
		ifFalse:
			[nextPC := bytecodePC + primDescriptor numBytes].

	fourArgBlock value: branchDescriptor value: nextPC value: postBranchPC value: targetBytecodePC