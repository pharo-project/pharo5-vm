in-line cacheing
cogMNUPICSelector: selector methodOperand: methodOperand numArgs: numArgs
	<api>
	"Attempt to create a one-case PIC for an MNU.
	 The tag for the case is at the send site and so doesn't need to be generated."
	<returnTypeC: #'CogMethod *'>
	| startAddress headerSize size end |
	(objectMemory isYoung: selector) ifTrue:
		[^0].
	coInterpreter
		compilationBreak: selector
		point: (objectMemory lengthOf: selector).
	self assert: endCPICCase0 notNil.
	startAddress := methodZone allocate: closedPICSize.
	startAddress = 0 ifTrue:
		[coInterpreter callForCogCompiledCodeCompaction.
		 ^0].
	methodLabel
		address: startAddress;
		dependent: nil.
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: numPICCases * 7 bytecodes: 0.
	self compileMNUCPIC: (self cCoerceSimple: startAddress to: #'CogMethod *')
		methodOperand: methodOperand
		numArgs: numArgs.
	self computeMaximumSizes.
	headerSize := self sizeof: CogMethod.
	size := self generateInstructionsAt: startAddress + headerSize.
	end := self outputInstructionsAt: startAddress + headerSize.
	"The missOffset is the same as the interpretOffset."
	self assert: missOffset = (interpretCall address + interpretCall machineCodeSize - startAddress).
	self assert: startAddress + cmEntryOffset = entry address.
	^self
		fillInCPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		size: closedPICSize
		numArgs: numArgs
		numCases: 1
		hasMNUCase: true
		selector: selector 