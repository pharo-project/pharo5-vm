compile abstract instructions
reinitializeFixupsFrom: start through: end
	"When a block must be recompiled due to overestimating the
	 numInitialNils fixups must be restored, which means rescannning
	 since backward branches need their targets initialized."
	| descriptor nExts pc distance targetPC |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	pc := start.
	nExts := 0.
	[pc <= end] whileTrue:
		[(self fixupAt: pc - initialPC) reinitialize.
		 byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 (descriptor isBranch
		  and: [self isBackwardBranch: descriptor at: pc exts: nExts in: methodObj]) ifTrue:
			[distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
			 targetPC := pc + descriptor numBytes + distance.
			 self initializeFixupAt: targetPC - initialPC].
		 descriptor isBlockCreation
			ifTrue:
				[distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
				 pc := pc + descriptor numBytes + distance]
			ifFalse: [pc := pc + descriptor numBytes].
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]]