bytecode generator support
existsInstVarRefBeforeSendOrReturn
	"Answer if the current bytecode is followed by an inst var ref before the next full send."
	| pc nExts descriptor |
	pc := bytecodePC.
	nExts := 0.
	[pc <= endPC] whileTrue:
		[descriptor := self generatorAt: pc.
		 (descriptor isMapped
		  or: [descriptor isBranchTrue
		  or: [descriptor isBranchFalse
		  or: [descriptor spanFunction notNil]]]) ifTrue:
			[^false].
		 descriptor isInstVarRef ifTrue:
			[^true].
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0].
		 pc := self nextBytecodePCFor: descriptor at: pc exts: nExts in: methodObj].
	^false