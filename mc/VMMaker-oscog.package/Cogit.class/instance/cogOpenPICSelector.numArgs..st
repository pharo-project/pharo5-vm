in-line cacheing
cogOpenPICSelector: selector numArgs: numArgs
	"Create an Open PIC.  Temporarily create a direct call of ceSendFromOpenPIC:.
	 Should become a probe of the first-level method lookup cache followed by a
	 call of ceSendFromOpenPIC: if the probe fails."
	<returnTypeC: #'CogMethod *'>
	| startAddress headerSize codeSize mapSize end |
	coInterpreter
		compilationBreak: selector
		point: (objectMemory lengthOf: selector).
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
	headerSize := self sizeof: CogMethod.
	codeSize := self generateInstructionsAt: startAddress + headerSize.
	mapSize := self generateMapAt: startAddress + openPICSize - 1 start: startAddress + cmNoCheckEntryOffset.
	self assert: entry address - startAddress = cmEntryOffset.
	self assert: headerSize + codeSize + mapSize <= openPICSize.
	end := self outputInstructionsAt: startAddress + headerSize.
	^self
		fillInOPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		size: openPICSize
		numArgs: numArgs
		selector: selector 