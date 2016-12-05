bytecode generator support
existsInstVarRefBeforeSendOrReturn
	"Answer if the current bytecode is followed by an inst var ref before the next full send."
	| pc nExts byte descriptor |
	pc := bytecodePC.
	nExts := 0.
	[pc <= endPC] whileTrue:
		[byte := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte.
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