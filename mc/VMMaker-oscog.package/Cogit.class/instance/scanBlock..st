compile abstract instructions
scanBlock: blockStart
	"Scan the block to determine if the block needs a frame or not"
	| descriptor pc end stackDelta nExts |
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	needsFrame := false.
	methodOrBlockNumArgs := blockStart numArgs.
	nExts := 0.
	pc := blockStart startpc.
	end := blockStart startpc + blockStart span.
	stackDelta := 0.
	[pc < end] whileTrue:
		[byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 needsFrame ifFalse:
			[(descriptor needsFrameFunction isNil
			  or: [self perform: descriptor needsFrameFunction with: true])
				ifTrue: [needsFrame := true]
				ifFalse: [stackDelta := stackDelta + descriptor stackDelta]].
		 pc := self nextBytecodePCFor: descriptor at: pc exts: nExts in: methodObj.
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
	needsFrame ifFalse:
		[stackDelta < 0 ifTrue:
			[self error: 'negative stack delta in block; block contains bogus code or internal error'].
		 [stackDelta > 0] whileTrue:
			[descriptor := self generatorAt: (objectMemory fetchByte: blockStart startpc ofObject: methodObj) + bytecodeSetOffset.
			 descriptor generator ~~ #genPushConstantNilBytecode ifTrue:
				[self error: 'frameless block doesn''t start with enough pushNils'].
			 blockStart
				startpc: blockStart startpc + descriptor numBytes;
				span: blockStart span - descriptor numBytes.
			 stackDelta := stackDelta - 1]]