compile abstract instructions
scanMethod
	"Scan the method (and all embedded blocks) to determine
		- what the last bytecode is; extra bytes at the end of a method are used to encode things like source pointers or temp names
		- if the method needs a frame or not
		- what are the targets of any backward branches.
		- how many blocks it creates
	 Answer the block count or on error a negative error code"
	| latestContinuation nExts descriptor pc numBlocks distance targetPC framelessStackDelta seenInstVarStore |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	needsFrame := useTwoPaths := seenInstVarStore := false.
	LowcodeVM ifTrue: [ hasNativeFrame := false ].
	self maybeInitNumFixups.
	self maybeInitNumCounters.
	prevBCDescriptor := nil.
	NewspeakVM ifTrue:
		[numIRCs := 0].
	(primitiveIndex > 0
	 and: [coInterpreter isQuickPrimitiveIndex: primitiveIndex]) ifTrue:
		[^0].
	pc := latestContinuation := initialPC.
	numBlocks := framelessStackDelta := nExts := extA := extB := 0.
	[pc <= endPC] whileTrue:
		[byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 descriptor isExtension ifTrue:
			[descriptor opcode = Nop ifTrue: "unknown bytecode tag; see Cogit class>>#generatorTableFrom:"
				[^EncounteredUnknownBytecode].
			 self loadSubsequentBytesForDescriptor: descriptor at: pc.
			 self perform: descriptor generator].
		 (descriptor isReturn
		  and: [pc >= latestContinuation]) ifTrue:
			[endPC := pc].

		  needsFrame ifFalse:
			[(descriptor needsFrameFunction isNil
			  or: [self perform: descriptor needsFrameFunction with: framelessStackDelta])
					ifTrue:
						["With immutability we win simply by avoiding a frame build if the receiver is young and not immutable."
						 self cppIf: IMMUTABILITY
							ifTrue: [descriptor is1ByteInstVarStore
									ifTrue: [useTwoPaths := true]
									ifFalse: [needsFrame := true. useTwoPaths := false]]
							ifFalse: [needsFrame := true. useTwoPaths := false]]
					ifFalse:
						[framelessStackDelta := framelessStackDelta + descriptor stackDelta.
						 "Without immutability we win if there are two or more stores and the receiver is new."
						 self cppIf: IMMUTABILITY
							ifTrue: []
							ifFalse:
								[descriptor is1ByteInstVarStore ifTrue:
									[seenInstVarStore
										ifTrue: [useTwoPaths := true]
										ifFalse: [seenInstVarStore := true]]]]].

		 descriptor isBranch ifTrue:
			[distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
			 targetPC := pc + descriptor numBytes + distance.
			 (self isBackwardBranch: descriptor at: pc exts: nExts in: methodObj)
				ifTrue: [self initializeFixupAt: targetPC - initialPC]
				ifFalse:
					[latestContinuation := latestContinuation max: targetPC.
					 self maybeCountFixup.
					 self maybeCountCounter]].
		 descriptor isBlockCreation ifTrue:
			[numBlocks := numBlocks + 1.
			 distance := self spanFor: descriptor at: pc exts: nExts in: methodObj.
			 targetPC := pc + descriptor numBytes + distance.
			 latestContinuation := latestContinuation max: targetPC.
			 self maybeCountFixup].

		 NewspeakVM ifTrue:
			[descriptor hasIRC ifTrue:
				[numIRCs := numIRCs + 1]].
		 pc := pc + descriptor numBytes.
		 descriptor isExtension
			ifTrue: [nExts := nExts + 1]
			ifFalse: [nExts := extA := extB := 0].
		 prevBCDescriptor := descriptor].
	^numBlocks