in-line cacheing
cogMNUPICSelector: selector receiver: rcvr methodOperand: methodOperand numArgs: numArgs
	<api>
	"Attempt to create a one-case PIC for an MNU.
	 The tag for the case is at the send site and so doesn't need to be generated."
	<returnTypeC: #'CogMethod *'>
	| startAddress |
	((objectMemory isYoung: selector)
	 or: [(objectRepresentation inlineCacheTagForInstance: rcvr) = self picAbortDiscriminatorValue]) ifTrue:
		[^0].
	coInterpreter
		compilationBreak: selector
		point: (objectMemory numBytesOf: selector)
		isMNUCase: true.
	self assert: endCPICCase0 notNil.
	"get memory in the code zone for the CPIC; if that fails we return an error code for the sender to use to work out how to blow up"
	startAddress := methodZone allocate: closedPICSize.
	startAddress = 0 ifTrue:
		[coInterpreter callForCogCompiledCodeCompaction.
		 ^0].

	"memcpy the prototype across to our allocated space; because anything else would be silly"
	objectMemory
		mem: (self cCoerceSimple: startAddress to: #'CogMethod *')
		cp: (self cCoerceSimple: cPICPrototype to: #'CogMethod *')
		y: closedPICSize.
	
	self configureMNUCPIC: (self cCoerceSimple: startAddress to: #'CogMethod *')
		methodOperand: methodOperand
		numArgs: numArgs
		delta: startAddress - cPICPrototype.

	^self
		fillInCPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		numArgs: numArgs
		numCases: 1
		hasMNUCase: true
		selector: selector 