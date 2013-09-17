compile abstract instructions
scanBlock: blockStart
	"Scan the block to determine if the block needs a frame or not"
	| descriptor pc end framelessStackDelta nExts pushingNils |
	<var: #blockStart type: #'BlockStart *'>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	needsFrame := false.
	prevBCDescriptor := nil.
	methodOrBlockNumArgs := blockStart numArgs.
	inBlock := true.
	pc := blockStart startpc.
	end := blockStart startpc + blockStart span.
	framelessStackDelta := nExts := 0.
	pushingNils := true.
	[pc < end] whileTrue:
		[byte0 := (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 descriptor := self generatorAt: byte0.
		 needsFrame ifFalse:
			[(descriptor needsFrameFunction isNil
			  or: [self perform: descriptor needsFrameFunction with: framelessStackDelta])
				ifTrue: [needsFrame := true]
				ifFalse: [framelessStackDelta := framelessStackDelta + descriptor stackDelta]].
		 (pushingNils
		  and: [descriptor isExtension not]) ifTrue:
			["Count the initial number of pushed nils acting as temp initializers.  We can't tell
			  whether an initial pushNil is an operand reference or a temp initializer, except
			  when the pushNil is a jump target (has a fixup) in which case it is definitely an
			  operand reference.  So rarely we may end up over-estimating.  We will correct
			  by checking the stack depth at the end of the block in compileBlockBodies."
			 (pushingNils := (self isPushNil: descriptor pc: pc nExts: nExts method: methodObj)
							  and: [(self fixupAt: pc - initialPC) targetInstruction = 0]) ifTrue:
				[self assert: descriptor numBytes = 1. "see compileMethodBody"
				 blockStart numInitialNils: blockStart numInitialNils + 1]].
		 pc := self nextBytecodePCFor: descriptor at: pc exts: nExts in: methodObj.
		 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0].
		 prevBCDescriptor := descriptor].
	"It would be nice of this wasn't necessary but alas we need to do the eager
	 scan for frameless methods so that we don't end up popping too much off
	 the simulated stack, e.g. for pushNil; returnTopFromBlock methods."
	needsFrame ifFalse:
		[self assert: (framelessStackDelta >= 0 and: [blockStart numInitialNils >= framelessStackDelta]).
		 blockStart numInitialNils: blockStart numInitialNils - framelessStackDelta]