compile abstract instructions
scanBlock: blockStart
	"Scan the block to determine if the block needs a frame or not"
	| descriptor pc end framelessStackDelta nExts pushingNils numPushNils |
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	needsFrame := false.
	LowcodeVM ifTrue: [ hasNativeFrame := false ].
	prevBCDescriptor := nil.
	methodOrBlockNumArgs := blockStart numArgs.
	inBlock := InVanillaBlock.
	pc := blockStart startpc.
	end := blockStart startpc + blockStart span.
	framelessStackDelta := nExts := extA := numExtB := extB := 0.
	pushingNils := true.
	[pc < end] whileTrue:
		[byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 descriptor isExtension ifTrue:
			[self loadSubsequentBytesForDescriptor: descriptor at: pc.
			 self perform: descriptor generator].
		 needsFrame ifFalse:
			[(descriptor needsFrameFunction isNil
			  or: [self perform: descriptor needsFrameFunction with: framelessStackDelta])
				ifTrue: [needsFrame := true]
				ifFalse: [framelessStackDelta := framelessStackDelta + descriptor stackDelta]].
		 objectRepresentation maybeNoteDescriptor: descriptor blockStart: blockStart.
		 (pushingNils
		  and: [descriptor isExtension not]) ifTrue:
			["Count the initial number of pushed nils acting as temp initializers.  We can't tell
			  whether an initial pushNil is an operand reference or a temp initializer, except
			  when the pushNil is a jump target (has a fixup), which never happens:
					self systemNavigation browseAllSelect:
						[:m| | ebc |
						(ebc := m embeddedBlockClosures
									select: [:ea| ea decompile statements first isMessage]
									thenCollect: [:ea| ea decompile statements first selector]) notEmpty
						and: [(#(whileTrue whileFalse whileTrue: whileFalse:) intersection: ebc) notEmpty]]
			  or if the bytecode set has a push multiple nils bytecode.  We simply count initial nils.
			  Rarely we may end up over-estimating.  We will correct by checking the stack depth
			  at the end of the block in compileBlockBodies."
			 (numPushNils := self numPushNils: descriptor pc: pc nExts: nExts method: methodObj) > 0
				ifTrue:
					[self assert: (descriptor numBytes = 1
									or: [descriptor generator == #genPushClosureTempsBytecode]).
					 blockStart numInitialNils: blockStart numInitialNils + numPushNils]
				ifFalse:
					[pushingNils := false]].
		 pc := self nextBytecodePCFor: descriptor at: pc exts: nExts in: methodObj.
		 descriptor isExtension
			ifTrue: [nExts := nExts + 1]
			ifFalse: [nExts := extA := numExtB := extB := 0].
		 prevBCDescriptor := descriptor].
	"It would be nice of this wasn't necessary but alas we need to do the eager
	 scan for frameless methods so that we don't end up popping too much off
	 the simulated stack, e.g. for pushNil; returnTopFromBlock methods."
	needsFrame ifFalse:
		[self assert: (framelessStackDelta >= 0 and: [blockStart numInitialNils >= framelessStackDelta]).
		 blockStart numInitialNils: blockStart numInitialNils - framelessStackDelta].
	^0