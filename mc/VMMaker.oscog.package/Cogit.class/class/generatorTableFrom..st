class initialization
generatorTableFrom: anArray
	| blockCreationBytecodeSize |
	generatorTable := CArrayAccessor on: (Array new: 256).
	anArray do:
		[:tuple| | descriptor |
		(descriptor := CogBytecodeDescriptor new)
						numBytes: tuple first;
						generator: tuple fourth;
						isReturn: (tuple includes: #return);
						isMapped: ((tuple includes: #isMappedIfImmutability)
										ifTrue: [self bindingOf: #IMMUTABILITY]
										ifFalse: [tuple includes: #isMapped]);
						isMappedInBlock: (tuple includes: #isMappedInBlock);
						isBlockCreation: (tuple includes: #block);
						spanFunction: (((tuple includes: #block) or: [(tuple includes: #branch)]) ifTrue:
										[tuple detect: [:thing| thing isSymbol and: [thing numArgs = 4]]]);
						isBranchTrue: (tuple includes: #isBranchTrue);
						isBranchFalse: (tuple includes: #isBranchFalse);
						isExtension: (tuple includes: #extension);
						isInstVarRef: (tuple includes: #isInstVarRef);	"for Spur"
						is1ByteInstVarStore: (tuple includes: #is1ByteInstVarStore);	"for Spur"
						hasIRC: (tuple includes: #hasIRC);			"for Newspeak"
						yourself.
		"As a hack to cut down on descriptor flags, use opcode to tag unusedBytecode for scanning.
		 Currently descriptors are exactly 16 bytes with all 8 flag bits used (in Newspeak at least 17 bytes,
		 9 flag bits).  As another hack to eliminate a test in scanMethod mark unknowns as extensions."
		descriptor generator == #unknownBytecode ifTrue:
			[descriptor opcode: Nop; isExtension: true].
		descriptor isBlockCreation ifTrue:
			[blockCreationBytecodeSize
				ifNil: [blockCreationBytecodeSize := descriptor numBytes]
				ifNotNil: [self assert: blockCreationBytecodeSize = descriptor numBytes]].
		tuple do:
			[:thing|
			thing isSymbol ifTrue:
				[(thing beginsWith: #needsFrame) ifTrue:
					[descriptor needsFrameFunction: thing].
				 (CogRTLOpcodes classPool at: thing ifAbsent: []) ifNotNil:
					[:opcode| descriptor opcode: opcode]]].
		tuple last isInteger
			ifTrue: [descriptor stackDelta: tuple last]
			ifFalse:
				[descriptor needsFrameFunction ifNotNil:
					[self error: 'frameless block bytecodes must specify a stack delta']].
		tuple second to: tuple third do:
			[:index|
			generatorTable at: index put: descriptor]].
	BlockCreationBytecodeSize := blockCreationBytecodeSize.
	^generatorTable