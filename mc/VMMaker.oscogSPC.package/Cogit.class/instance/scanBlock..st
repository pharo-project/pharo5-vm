compile abstract instructions
scanBlock: blockStart
	"Scan the block to determine if the block needs a frame or not"
	| descriptor pc end framelessStackDelta nExts |
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	needsFrame := false.
	methodOrBlockNumArgs := blockStart numArgs.
	inBlock := InVanillaBlock.
	pc := blockStart startpc.
	end := blockStart startpc + blockStart span.
	framelessStackDelta := nExts := extA := numExtB := extB := 0.
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
		 pc := self nextBytecodePCFor: descriptor at: pc exts: nExts in: methodObj.
		 descriptor isExtension
			ifTrue: [nExts := nExts + 1]
			ifFalse: [nExts := extA := numExtB := 0. extB := 0]].
	needsFrame ifFalse:
		[framelessStackDelta < 0 ifTrue:
			[self error: 'negative stack delta in block; block contains bogus code or internal error'].
		 [framelessStackDelta > 0] whileTrue:
			[descriptor := self generatorAt: (objectMemory fetchByte: blockStart startpc ofObject: methodObj) + bytecodeSetOffset.
			 descriptor generator ~~ #genPushConstantNilBytecode ifTrue:
				[self error: 'frameless block doesn''t start with enough pushNils'].
			 blockStart
				startpc: blockStart startpc + descriptor numBytes;
				span: blockStart span - descriptor numBytes.
			 framelessStackDelta := framelessStackDelta - 1]].
	^0