in-line cacheing
cogPICSelector: selector numArgs: numArgs Case0Method: case0CogMethod Case1Method: case1MethodOrNil tag: case1Tag isMNUCase: isMNUCase
	"Attempt to create a two-case PIC for case0CogMethod and  case1Method,case1Tag.
	 The tag for case0CogMethod is at the send site and so doesn't need to be generated.
	 case1Method may be any of
		- a Cog method; link to its unchecked entry-point
		- a CompiledMethod; link to ceInterpretMethodFromPIC:
		- a CompiledMethod; link to ceMNUFromPICMNUMethod:receiver:"
	<var: #case0CogMethod type: #'CogMethod *'>
	<returnTypeC: #'CogMethod *'>
	| startAddress headerSize size end |
	(objectMemory isYoung: selector) ifTrue:
		[^self cCoerceSimple: YoungSelectorInPIC to: #'CogMethod *'].
	coInterpreter
		compilationBreak: selector
		point: (objectMemory lengthOf: selector).
	startAddress := methodZone allocate: closedPICSize.
	startAddress = 0 ifTrue:
		[^self cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].
	methodLabel
		address: startAddress;
		dependent: nil.
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: numPICCases * 7 bytecodes: 0.
	self compileCPIC: (self cCoerceSimple: startAddress to: #'CogMethod *')
		Case0: case0CogMethod
		Case1Method: case1MethodOrNil
		tag: case1Tag
		isMNUCase: isMNUCase
		numArgs: numArgs.
	self computeMaximumSizes.
	headerSize := self sizeof: CogMethod.
	size := self generateInstructionsAt: startAddress + headerSize.
	end := self outputInstructionsAt: startAddress + headerSize.
	"The missOffset is th same as the interpretOffset."
	self assert: missOffset = (interpretCall address + interpretCall machineCodeSize - startAddress).
	self assert: startAddress + cmEntryOffset = entry address.
	self assert: endCPICCase0 address = (startAddress + firstCPICCaseOffset).
	self assert: endCPICCase1 address = (startAddress + firstCPICCaseOffset + cPICCaseSize).
	^self
		fillInCPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		size: closedPICSize
		numArgs: numArgs
		numCases: 2
		hasMNUCase: isMNUCase
		selector: selector 