compile abstract instructions
reinitializeAllButBackwardFixupsFrom: start through: end
	"When a method must be recompiled due to moving a loop's register
	 assignments to the head of a loop, backward fixups must be marked
	 as such, and all but backward fixups must be reinitialized."
	<inline: true>
	| descriptor nExts pc distance targetPC |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	pc := start.
	nExts := 0.
	[pc <= end] whileTrue:
		[byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 (descriptor isBranch
		  and: [self isBackwardBranch: descriptor at: pc exts: nExts in: methodObj]) ifTrue:
			[distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
			 targetPC := pc + descriptor numBytes + distance.
			 self initializeFixupAt: targetPC].
		 descriptor isBlockCreation
			ifTrue:
				[distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
				 pc := pc + descriptor numBytes + distance]
			ifFalse: [pc := pc + descriptor numBytes].
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	start to: end do:
		[:i| | fixup |
		 fixup := self fixupAt: i.
		 (fixup notAFixup or: [fixup isBackwardBranchFixup]) ifFalse:
			[fixup reinitialize]]