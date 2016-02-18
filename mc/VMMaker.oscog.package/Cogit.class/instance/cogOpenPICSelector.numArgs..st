in-line cacheing
cogOpenPICSelector: selector numArgs: numArgs
	"Create an Open PIC.  Temporarily create a direct call of ceSendFromOpenPIC:.
	 Should become a probe of the first-level method lookup cache followed by a
	 call of ceSendFromOpenPIC: if the probe fails."
	<returnTypeC: #'CogMethod *'>
	| startAddress codeSize mapSize end |
	coInterpreter
		compilationBreak: selector
		point: (objectMemory numBytesOf: selector)
		isMNUCase: false.
	startAddress := methodZone allocate: openPICSize.
	startAddress = 0 ifTrue:
		[^self cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].
	methodLabel
		address: startAddress;
		dependent: nil.
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: 100 bytecodes: 0.
	self compileOpenPIC: selector numArgs: numArgs.
	self computeMaximumSizes.
	methodLabel concretizeAt: startAddress.
	codeSize := self generateInstructionsAt: startAddress + (self sizeof: CogMethod).
	mapSize := self generateMapAt: startAddress + openPICSize - 1 start: startAddress + cmNoCheckEntryOffset.
	self assert: entry address - startAddress = cmEntryOffset.
	self assert: (methodZone roundUpLength: (self sizeof: CogMethod) + codeSize) + (methodZone roundUpLength: mapSize) <= openPICSize.
	end := self outputInstructionsAt: startAddress + (self sizeof: CogMethod).
	^self
		fillInOPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		numArgs: numArgs
		selector: selector 