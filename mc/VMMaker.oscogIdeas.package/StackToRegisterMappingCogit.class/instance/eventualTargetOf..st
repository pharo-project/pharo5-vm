peephole optimizations
eventualTargetOf: targetBytecodePC
	"Attempt to follow a branch to a pc.  Handle branches to unconditional jumps
	 and branches to push: aBoolean; conditional branch pairs.  If the branch cannot
	 be followed answer targetBytecodePC."

	| currentTarget nextPC nExts descriptor span cond |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	nextPC := currentTarget := targetBytecodePC.
	[ nExts := 0.
	 [descriptor := self generatorAt: bytecodeSetOffset
								+ (objectMemory fetchByte: nextPC ofObject: methodObj).
	  descriptor isReturn ifTrue: [^currentTarget]. "avoid stepping off the end of methods"
	  descriptor isExtension]
		whileTrue:
			[nExts := nExts + 1.
			 nextPC := nextPC + descriptor numBytes].
	 descriptor isUnconditionalBranch
		ifTrue:
			[span := self spanFor: descriptor at: nextPC exts: nExts in: methodObj.
			 span < 0 ifTrue: "Do *not* follow backward branches; these are interrupt points and should not be elided."
				[^currentTarget].
			 nextPC := nextPC + descriptor numBytes + span]
		ifFalse:
			[descriptor generator == #genPushConstantTrueBytecode ifTrue: [ cond := true ]
			 ifFalse: [ descriptor generator == #genPushConstantFalseBytecode ifTrue: [ cond := false ]
			 ifFalse: [ ^currentTarget ] ].
			 "Don't step into loops across a pushTrue; jump:if: boundary, so as not to confuse stack depth fixup."
			 (self fixupAt: nextPC) isBackwardBranchFixup ifTrue:
				[^currentTarget].
			 nextPC := self eventualTargetOf: nextPC + descriptor numBytes.
			 nExts := 0.
			 [descriptor := self generatorAt: bytecodeSetOffset
								+ (objectMemory fetchByte: nextPC ofObject: methodObj).
			  descriptor isReturn ifTrue: [^currentTarget]. "avoid stepping off the end of methods"
			  descriptor isExtension]
				whileTrue:
					[nExts := nExts + 1.
					 nextPC := nextPC + descriptor numBytes].
			 descriptor isBranch ifFalse:
				[^currentTarget].
			 descriptor isUnconditionalBranch ifTrue:
				[^currentTarget].
			 nextPC := cond == descriptor isBranchTrue
									ifTrue: [nextPC
											+ descriptor numBytes
											+ (self spanFor: descriptor at: nextPC exts: nExts in: methodObj)]
									ifFalse: [nextPC + descriptor numBytes]].
	 currentTarget := nextPC]
		repeat