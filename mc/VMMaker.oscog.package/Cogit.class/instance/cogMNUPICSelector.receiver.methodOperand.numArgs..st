in-line cacheing
cogMNUPICSelector: selector receiver: rcvr methodOperand: methodOperand numArgs: numArgs
	<api>
	"Attempt to create a one-case PIC for an MNU.
	 The tag for the case is at the send site and so doesn't need to be generated."
	<returnTypeC: #'CogMethod *'>
	| startAddress size end |
	((objectMemory isYoung: selector)
	 or: [(objectRepresentation inlineCacheTagForInstance: rcvr) = self picAbortDiscriminatorValue]) ifTrue:
		[^0].
	coInterpreter
		compilationBreak: selector
		point: (objectMemory numBytesOf: selector)
		isMNUCase: true.
	self assert: endCPICCase0 notNil.
	startAddress := methodZone allocate: closedPICSize.
	startAddress = 0 ifTrue:
		[coInterpreter callForCogCompiledCodeCompaction.
		 ^0].
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: numPICCases * 9 bytecodes: 0.
	methodLabel address: startAddress; dependent: nil. "for pc-relative MoveCw: cPIC R: ClassReg"
	self compileMNUCPIC: (self cCoerceSimple: startAddress to: #'CogMethod *')
		methodOperand: methodOperand
		numArgs: numArgs.
	self computeMaximumSizes.
	size := self generateInstructionsAt: startAddress + (self sizeof: CogMethod).
	end := self outputInstructionsAt: startAddress + (self sizeof: CogMethod).
	"The missOffset is the same as the interpretOffset. On RISCs it includes an additional instruction."
	self assert: missOffset = ((backEnd hasLinkRegister ifTrue: [backEnd callInstructionByteSize] ifFalse: [0])
								+ picInterpretAbort address + picInterpretAbort machineCodeSize - startAddress).
	self assert: startAddress + cmEntryOffset = entry address.
	^self
		fillInCPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		numArgs: numArgs
		numCases: 1
		hasMNUCase: true
		selector: selector 