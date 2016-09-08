disassembly
blockStartPcsIn: aMethod
	"Answer the start bytecopde pcs in a method in compilation order, i.e. depth-first.
	 Blocks must occur in pc/depth-first order for binary tree block dispatch to work."
	| startpcs pc latestContinuation end descriptor byte bsOffset nExts |
	<doNotGenerate>
	startpcs := OrderedCollection new.
	startpcs add: (pc := latestContinuation := coInterpreter startPCOfMethod: aMethod).
	end := objectMemory numBytesOf: aMethod.
	bsOffset := self bytecodeSetOffsetFor: aMethod.
	nExts := 0.
	[pc <= end] whileTrue:
		[byte := objectMemory fetchByte: pc ofObject: aMethod.
		 descriptor := self generatorAt: byte + bsOffset.
		 (descriptor isReturn
		  and: [pc >= latestContinuation]) ifTrue:
			[end := pc].
		 (descriptor isBranch
		  or: [descriptor isBlockCreation]) ifTrue:
			[| targetPC |
			 targetPC := self latestContinuationPCFor: descriptor at: pc exts: nExts in: aMethod.
			 latestContinuation := latestContinuation max: targetPC].
		 pc := pc + descriptor numBytes.
		 descriptor isBlockCreation ifTrue:
			[startpcs add: pc].
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	^startpcs